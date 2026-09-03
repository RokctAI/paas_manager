// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:base_sdk/src/handlers/platform_gateway.dart';
import 'package:base_sdk/src/models/data/shop_data.dart';
import 'package:base_sdk/src/models/data/translation.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:base_sdk/src/sync/sync_engine.dart';
import 'package:merchants_sdk/src/manager/domain/interface/seller_shop.dart';
import 'package:merchants_sdk/src/manager/infrastructure/models/response/my_shop_response.dart';
import 'package:merchants_sdk/src/manager/infrastructure/services/manager_shops_local_store.dart';
import 'package:merchants_sdk/src/manager/infrastructure/services/shop_create_sync_handler.dart';

/// Port of the shop-management half of `paas_manager`'s `UsersRepository`,
/// repointed from the legacy `/api/v1/dashboard/seller/...` paths to
/// `seller_shop.py` / `seller_shop_settings.py` in the merchants Frappe app,
/// reached as `api.shop.*` / `api.seller_shop.*` / `api.seller_shop_settings.*`
/// cmds through the universal gateway. Endpoint-by-endpoint state (including
/// the recorded gaps: `order_payment`, seller wallet, `rating_avg` in the shop
/// payload) lives in `docs/frappe-endpoint-contract.md`. A call the backend
/// cannot answer yet fails through [ApiResult.failure] rather than being
/// faked.
class SellerShopRepository implements SellerShopRepositoryFacade {
  /// Universal platform gateway (fleet rule 2026-08-15): cmds mirror this
  /// module's `manifest.json` whitelisted-method keys with the app segment
  /// dropped.
  static const _gateway = PlatformGateway();

  ApiResult<T> _fail<T>(Object e, String label) {
    debugPrint('==> $label failure: $e');
    return ApiResult.failure(
      error: AppHelpers.errorHandler(e),
      statusCode: NetworkExceptions.getDioStatus(e),
    );
  }

  @override
  Future<ApiResult<void>> createShop({
    required String name,
    String? phone,
    String? address,
  }) async {
    // `create_shop` requires only `shop_name` (user defaults to the session
    // user, uuid/slug are generated server-side); everything else rides
    // along only when the seller typed it. The legacy host posted the whole
    // management payload to `/api/v1/dashboard/user/shops` — that material
    // now lands post-create through `updateShop`.
    final shopData = {
      'shop_name': name,
      if (phone != null && phone.isNotEmpty)
        'phone': phone.replaceAll('+', ''),
      if (address != null && address.isNotEmpty) 'address': address,
    };
    // Local-first: write the record through before the network attempt so a
    // dead connection can never lose the manager's input.
    final String localId = SyncEngine.newTempId();
    await ManagerShopsLocalStore.putPending(localId, {'shop_data': shopData});
    try {
      // Same cmd + payload shape the outbox handler replays
      // (ShopCreateSyncHandler): shop.create_shop(shop_data).
      await _gateway.tenant('api.shop.create_shop', {'shop_data': shopData});
      // Backend reachable and accepted: it is authoritative from here on
      // (getMyShop supplies the shop), so the write-through record goes.
      await ManagerShopsLocalStore.delete(localId);
      return const ApiResult.success(data: null);
    } catch (e) {
      final status = NetworkExceptions.getDioStatus(e);
      if (status >= 400 && status < 500 && status != 408) {
        // Backend reachable and said no — unchanged backend-first behavior;
        // the local record must not survive a definitive rejection.
        await ManagerShopsLocalStore.delete(localId);
        return _fail(e, 'create shop');
      }
      // Backend unreachable / transient: keep the record, queue the push and
      // report success — the SyncEngine drains it on boot or connectivity
      // regain (getDioStatus maps connection failures and timeouts to 500).
      await SyncEngine().enqueue(
        opType: ShopCreateSyncHandler.opType,
        sdk: ShopCreateSyncHandler.sdkName,
        payload: {'localId': localId, 'shop_data': shopData},
        tempIds: [localId],
      );
      await _seedCachedShop(localId, name: name, phone: phone, address: address);
      return const ApiResult.success(data: null);
    }
  }

  /// A first-time seller with no cached shop needs `getShopJson()?['id']` to
  /// resolve for offline product/order creation, so seed the cache with the
  /// temp id (`ShopData.id` is a String, so the token round-trips safely).
  /// A cached shop is never clobbered.
  Future<void> _seedCachedShop(
    String localId, {
    required String name,
    String? phone,
    String? address,
  }) async {
    if (LocalStorage.getShopJson() != null) return;
    await LocalStorage.setShopJson({
      'id': localId,
      'shop_name': name,
      'translation': {'title': name, 'address': address},
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      'pending_sync': true,
    });
  }

  @override
  Future<ApiResult<MyShopResponse>> getMyShop() async {
    try {
      final response = await _gateway.tenant(
        'api.seller_shop.get_shop',
        {
          'lang': LocalStorage.getLanguage()?.locale,
          'currency_id': LocalStorage.getSelectedCurrency()?.id,
        },
      );
      return ApiResult.success(data: MyShopResponse.fromJson(response));
    } catch (e) {
      return _fail(e, 'get my shop');
    }
  }

  @override
  Future<ApiResult<MyShopResponse>> updateShop({
    String? backImg,
    String? logoImg,
    String? phone,
    String? tax,
    String? minAmount,
    Translation? translation,
    String? deliveryTimeType,
    String? deliveryTimeFrom,
    String? deliveryTimeTo,
    String? orderPayment,
  }) async {
    // `update_shop` reads a flat allowed-fields dict; title/description/
    // address are flat strings (no per-locale map — recorded gap: the legacy
    // API took `{locale: text}` maps, Frappe stores a single value).
    final shopData = {
      if (translation?.title != null) 'title': translation?.title,
      if (translation?.description != null)
        'description': translation?.description,
      if (translation?.address != null) 'address': translation?.address,
      if (phone != null) 'phone': phone.replaceAll('+', ''),
      if (tax != null) 'tax': tax,
      if (minAmount != null) 'min_amount': minAmount,
      if (logoImg != null) 'logo_img': logoImg,
      if (backImg != null) 'background_img': backImg,
      if (deliveryTimeType != null) 'delivery_time_type': deliveryTimeType,
      if (deliveryTimeFrom != null) 'delivery_time_from': deliveryTimeFrom,
      if (deliveryTimeTo != null) 'delivery_time_to': deliveryTimeTo,
      // Not in update_shop's allowed fields yet; sent so it starts landing
      // the moment the backend accepts it (recorded gap).
      if (orderPayment != null) 'order_payment': orderPayment,
    };
    try {
      final response = await _gateway.tenant(
        'api.seller_shop.update_shop',
        {'shop_data': shopData},
      );
      return ApiResult.success(data: MyShopResponse.fromJson(response));
    } catch (e) {
      return _fail(e, 'update shop');
    }
  }

  @override
  Future<ApiResult<void>> setWorkingStatus({required bool open}) async {
    try {
      // seller_shop.set_working_status(status) — the whitelisted alias;
      // `set_shop_working_status` is its un-aliased legacy twin.
      await _gateway.tenant(
        'api.seller_shop.set_working_status',
        {'status': open},
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      return _fail(e, 'set shop working status');
    }
  }

  @override
  Future<ApiResult<List<ShopWorkingDay>>> getShopWorkingDays() async {
    try {
      final dynamic body = await _gateway.tenant(
        'api.seller_shop_settings.get_seller_shop_working_days',
      );
      final List<dynamic> list =
          body is List ? body : (body?['dates'] as List<dynamic>? ?? []);
      // Built by hand rather than ShopWorkingDay.fromJson: base's fromJson
      // requires created_at/updated_at, which neither wire shape carries
      // here. Keys are mapped from the Frappe fields (day_of_week/
      // opening_time/closing_time/is_closed) with legacy fallbacks.
      int index = 0;
      final days = list.map((dynamic v) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(v);
        return ShopWorkingDay(
          id: json['id'] ?? index++,
          day: (json['day'] ?? json['day_of_week'])?.toString().toLowerCase(),
          from: (json['from'] ?? json['opening_time'])?.toString(),
          to: (json['to'] ?? json['closing_time'])?.toString(),
          disabled: json['disabled'] is bool
              ? json['disabled']
              : (json['is_closed'] == null ? false : json['is_closed'] == 1),
        );
      }).toList();
      return ApiResult.success(data: days);
    } catch (e) {
      return _fail(e, 'get shop working days');
    }
  }

  @override
  Future<ApiResult<void>> updateShopWorkingDays({
    required List<ShopWorkingDay> workingDays,
    String? uuid,
  }) async {
    final days = workingDays
        .map(
          (day) => {
            'day_of_week': day.day,
            'opening_time': day.from,
            'closing_time': day.to,
            'is_closed': (day.disabled ?? false) ? 1 : 0,
          },
        )
        .toList();
    try {
      await _gateway.tenant(
        'api.seller_shop_settings.update_seller_shop_working_days',
        {'working_days_data': days},
      );
      return const ApiResult.success(data: null);
    } catch (e) {
      return _fail(e, 'update shop working days');
    }
  }
}
