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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:base_sdk/src/presentation/adaptive/planes.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:kitchen_sdk/src/manager/application/kitchen/kitchen_provider.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_detail_pane.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_plane_flow.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_queue_view.dart';

/// The whole manager Kitchen screen body — everything below the shell:
/// fetch-on-mount and the auto-refresh polling lifecycle, hosted in the
/// approved plane behaviour ([KitchenPlaneFlow]). The tab page template
/// mounts exactly this widget.
class KitchenWorkspace extends ConsumerStatefulWidget {
  const KitchenWorkspace({super.key});

  @override
  ConsumerState<KitchenWorkspace> createState() => _KitchenWorkspaceState();
}

class _KitchenWorkspaceState extends ConsumerState<KitchenWorkspace> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(kitchenProvider.notifier);
      notifier.fetchOrders(isRefresh: true);
      notifier.startPolling();
    });
  }

  @override
  void deactivate() {
    ref.read(kitchenProvider.notifier).stopPolling();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(kitchenProvider.select((s) => s.selectedOrder));
    return ColoredBox(
      color: AppStyle.surfaceDark,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // On a ONE-plane (phone) width the detail is a real pushed
          // route (KitchenDetailPage, approved 34c) — the flow hosts the
          // queue alone there, so the selection a pushed route holds
          // never double-mounts a detail plane beneath it.
          final bool onePlane =
              PlaneHost.planeCountFor(constraints.maxWidth) == 1;
          return KitchenPlaneFlow(
            selectedOrder: onePlane ? null : selected,
            queueBuilder: (context) => const KitchenQueueView(),
            detailBuilder: (context, order) => KitchenDetailPane(order: order),
            onCloseDetail: () =>
                ref.read(kitchenProvider.notifier).selectOrder(null),
          );
        },
      ),
    );
  }
}
