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

import 'package:kitchen_sdk/src/manager/infrastructure/models/data/kitchen_order_data.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_status.dart';

/// Immutable state of the manager Kitchen screen (hand-written — this SDK
/// carries no codegen, the picker state's precedent).
class KitchenState {
  final bool isLoading;
  final bool isUpdating;
  final List<KitchenOrderData> orders;
  final Map<KitchenFilter, int> counts;

  /// Total for the ACTIVE filter — drives "View more · +N".
  final int total;

  final KitchenFilter filter;
  final String query;

  /// The selected order's docname; null = nothing selected (phone queue,
  /// or an empty queue).
  final String? selectedId;

  /// The bell's activity dot — set when the chime fires, cleared by
  /// tapping the bell.
  final bool hasNewActivity;

  const KitchenState({
    this.isLoading = false,
    this.isUpdating = false,
    this.orders = const [],
    this.counts = const {},
    this.total = 0,
    this.filter = KitchenFilter.all,
    this.query = '',
    this.selectedId,
    this.hasNewActivity = false,
  });

  KitchenOrderData? get selectedOrder {
    if (selectedId == null) return null;
    for (final order in orders) {
      if (order.id == selectedId) return order;
    }
    return null;
  }

  int countOf(KitchenFilter filter) => counts[filter] ?? 0;

  /// "View more" remainder for the active filter.
  int get moreCount =>
      (total - orders.length) > 0 ? total - orders.length : 0;

  KitchenState copyWith({
    bool? isLoading,
    bool? isUpdating,
    List<KitchenOrderData>? orders,
    Map<KitchenFilter, int>? counts,
    int? total,
    KitchenFilter? filter,
    String? query,
    String? selectedId,
    bool clearSelection = false,
    bool? hasNewActivity,
  }) => KitchenState(
    isLoading: isLoading ?? this.isLoading,
    isUpdating: isUpdating ?? this.isUpdating,
    orders: orders ?? this.orders,
    counts: counts ?? this.counts,
    total: total ?? this.total,
    filter: filter ?? this.filter,
    query: query ?? this.query,
    selectedId: clearSelection ? null : (selectedId ?? this.selectedId),
    hasNewActivity: hasNewActivity ?? this.hasNewActivity,
  );
}
