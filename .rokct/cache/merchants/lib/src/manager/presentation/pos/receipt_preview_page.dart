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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/adaptive/planes.dart';
import 'package:base_sdk/src/presentation/components/floating_nav/floating_bottom_nav.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/key_sound.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:merchants_sdk/src/manager/application/pos_cart/pos_cart_provider.dart';
import 'package:merchants_sdk/src/manager/application/pos_cart/pos_sale_finish.dart';
import 'package:merchants_sdk/src/manager/domain/interface/pos_orders.dart';
import 'package:merchants_sdk/src/manager/presentation/pos/receipt_slip.dart';

/// The receipt preview — the step between checkout and print (approved
/// frame 11k, Ray 2026-08-29 13:53Z), and the receipt as ONE plane
/// (frame 11r, 13:06Z — "the best ui ever", the reference standard for
/// the newest thing taking its own plane at its natural size).
///
/// "Print Receipt & Finish" (293) on the checkout lands HERE first, so
/// printing never fires blind: the operator sees the paper slip (322 —
/// the same widget in both homes, never stretched) under the 171-pattern
/// bare title (304), with the checkout's dual finish beneath the paper,
/// verbatim treatment — "Print Receipt & Finish" stays ATOMIC (print,
/// then record: a dead printer leaves the sale open) and "Finish without
/// Receipt" (294) skips the print. The pipeline is the checkout's own
/// [PosSaleFinish]; on success this page clears the cart and hands the
/// host [onFinished].
///
/// Two homes, one widget:
///  * PHONE (11k): pushed above the checkout as a plain route; the
///    section-12 back-only floating pill is its single back affordance
///    (one back per screen, no PopButton) and pops back to the checkout;
///  * PLANES (11r): the till pushes it onto its PlaneHost stack claiming
///    ONE plane (PlaneSpan.one — the default, "the receipt needs no
///    more") in place of the checkout; the host draws the END-corner back
///    pill (12c/12d), so this page draws none.
class ReceiptPreviewPage extends ConsumerStatefulWidget {
  const ReceiptPreviewPage({
    super.key,
    required this.receipt,
    required this.sale,
    required this.onFinished,
  });

  /// What the slip shows — the checkout's snapshot at the tap.
  final PosReceiptData receipt;

  /// What either finish records.
  final PosSaleFinish sale;

  /// The sale is recorded and the cart cleared: the host leaves — the
  /// phone route pops, the till drops the plane.
  final VoidCallback onFinished;

  @override
  ConsumerState<ReceiptPreviewPage> createState() => _ReceiptPreviewPageState();
}

class _ReceiptPreviewPageState extends ConsumerState<ReceiptPreviewPage> {
  /// A finish in flight — the buttons ignore re-taps.
  bool _finishing = false;

  PosOrdersFacade? get _posOrders => GetIt.I.isRegistered<PosOrdersFacade>()
      ? GetIt.I<PosOrdersFacade>()
      : null;

  Future<void> _finish({required bool withReceipt}) async {
    if (_finishing) return;
    _finishing = true;
    try {
      final failure = await widget.sale.run(
        withReceipt: withReceipt,
        facade: _posOrders,
      );
      if (!mounted) return;
      if (failure != null) {
        KeySound.error();
        AppHelpers.showCheckTopSnackBar(
          context,
          failure.printFailed
              ? AppHelpers.getTranslation(TrKeys.printFailed)
              : failure.message ??
                  AppHelpers.getTranslation(
                    TrKeys.somethingWentWrongWithTheServer,
                  ),
        );
        return;
      }
      ref.read(posCartProvider.notifier).finishSale();
      AppHelpers.showCheckTopSnackBarDone(
        context,
        AppHelpers.getTranslation(TrKeys.saleCompleted),
      );
      widget.onFinished();
    } finally {
      _finishing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hosted in the till's planes (11r): the host owns the back pill.
    final Planes? planes = Planes.maybeOf(context);
    final bool inPlanes = planes != null && planes.count > 1;
    return Scaffold(
      backgroundColor: AppStyle.surfaceDark,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(16.r),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _header(context),
                    20.verticalSpace,
                    ReceiptSlip(receipt: widget.receipt),
                    24.verticalSpace,
                    _finishButtons(context),
                    120.verticalSpace,
                  ]),
                ),
              ),
            ],
          ),
          if (!inPlanes)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingBottomNav(
                  mode: FloatingNavTabsMode(
                    tabs: const [],
                    currentIndex: 0,
                    onSelect: (_) {},
                    back: FloatingNavBack(
                      icon: Remix.arrow_left_wide_fill,
                      label: AppHelpers.getTranslation(TrKeys.back),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Chip 304: the shared 171-pattern bare title ("Receipt") — no
  /// AppBar, no page back button.
  Widget _header(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            AppHelpers.getTranslation(TrKeys.receipt),
            style: AppStyle.interSemi(size: 18.sp, color: AppStyle.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Chips 293/294 on the dark screen beneath the slip — the checkout's
  /// dual finish, verbatim treatment.
  Widget _finishButtons(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          key: const Key('posReceiptPrintFinish'),
          onTap: () => unawaited(_finish(withReceipt: true)),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 56.r),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppStyle.primary,
              borderRadius: BorderRadius.circular(16.r),
            ),
            alignment: Alignment.center,
            child: Text(
              AppHelpers.getTranslation(TrKeys.printReceipt),
              textAlign: TextAlign.center,
              style: AppStyle.interSemi(size: 16, color: AppStyle.blackColor),
            ),
          ),
        ),
        14.verticalSpace,
        GestureDetector(
          key: const Key('posReceiptFinishWithout'),
          onTap: () => unawaited(_finish(withReceipt: false)),
          child: Container(
            width: double.infinity,
            height: 56.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppStyle.blue, width: 1.r),
            ),
            alignment: Alignment.center,
            child: Text(
              AppHelpers.getTranslation(TrKeys.finish),
              style: AppStyle.interSemi(size: 16, color: AppStyle.blue),
            ),
          ),
        ),
      ],
    );
  }
}
