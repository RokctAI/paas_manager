// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:base_sdk/src/presentation/components/floating_nav/floating_bottom_nav.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:base_sdk/src/services/tr_keys.dart';
import 'package:kitchen_sdk/src/manager/application/kitchen/kitchen_provider.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_detail_pane.dart';

/// The PHONE's pushed order detail (approved 34c): tapping a queue card
/// pushes this page as a REAL route — it covers the whole home shell,
/// including its centered floating nav, which is exactly the 12:36Z
/// nav-fold moment: the only affordance left is the corner
/// [FloatingBackPill] at the bottom-END. Back pops the route and lands on
/// the queue with the full nav again.
///
/// Content is the same [KitchenDetailPane] the wide layout puts in the
/// last plane, kept live through the shared provider (polling refreshes
/// reach an open detail). If the selection dies underneath (the order was
/// handed over and left the queue on refresh), the page pops itself.
class KitchenDetailPage extends ConsumerWidget {
  const KitchenDetailPage({super.key});

  /// Pushes the page, clearing the selection when it pops.
  static Future<void> push(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(builder: (_) => const KitchenDetailPage()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(kitchenProvider.select((s) => s.selectedOrder));
    ref.listen(kitchenProvider.select((s) => s.selectedOrder), (previous, next) {
      if (next == null && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      backgroundColor: AppStyle.surfaceDark,
      body: SafeArea(
        child: order == null
            ? const SizedBox.shrink()
            : Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      // Keep the action buttons clear of the corner pill
                      // (the harness frames' 92px reserve).
                      padding: const EdgeInsets.only(bottom: 76),
                      child: KitchenDetailPane(order: order),
                    ),
                  ),
                  PositionedDirectional(
                    end: 16,
                    bottom: 16,
                    child: FloatingBackPill(
                      back: FloatingNavBack(
                        icon: FlutterRemix.arrow_left_s_line,
                        label: AppHelpers.getTranslation(TrKeys.back),
                        onTap: () => Navigator.of(context).maybePop(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
