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

// Demo runs the REAL KitchenOrdersRepository and KitchensRepository:
// base_sdk's DemoGatewayInterceptor answers their cmds from
// templates/assets/demo/kitchen.

import 'package:flutter_test/flutter_test.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/repositories/kitchen_orders_repository.dart';
import 'package:kitchen_sdk/src/manager/infrastructure/repositories/kitchens_repository.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_status.dart';

import 'support/demo_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(startDemoFixtures);
  tearDown(stopDemoFixtures);

  test(
    'the seeded service: five tickets across the three live columns',
    () async {
      final repo = KitchenOrdersRepository();
      final all = ok(await repo.getKitchenOrders());
      expect(all.orders.map((o) => o.id), [
        '1041',
        '1040',
        '1039',
        '1038',
        '1037',
      ]);
      expect(all.total, 5);
      expect(all.counts[KitchenFilter.cooking], 2);
      expect(all.orders.first.dishes.first.title, 'Peri-peri chicken wrap');
      expect(all.orders.first.dishes.first.prepStatus, DishStatus.pending);
      final cooking = ok(
        await repo.getKitchenOrders(status: KitchenStatus.cooking),
      );
      expect(cooking.orders.map((o) => o.id), ['1039', '1038']);
      expect(ok(await repo.getKitchenOrders(page: 2)).orders, isEmpty);
      ok(await repo.updateOrderStatus(orderId: '1041', wireStatus: 'cooking'));
      ok(
        await repo.updateDishStatus(
          orderId: '1041',
          dishId: '1',
          status: DishStatus.done,
        ),
      );
    },
  );

  test('the kitchen stations', () async {
    final kitchens = ok(await KitchensRepository().getKitchens());
    expect(kitchens.data!.map((k) => k.translation?.title), ['Grill', 'Fryer']);
  });
}
