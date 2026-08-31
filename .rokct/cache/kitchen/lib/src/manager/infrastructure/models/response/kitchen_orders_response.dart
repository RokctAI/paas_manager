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

/// `api.cook.get_kitchen_orders` answer:
/// `{"orders": [...], "counts": {"all": n, "accepted": n, ...}, "total": n}`
/// — counts feed the filter chips, total the active filter's paging.
class KitchenOrdersResponse {
  final List<KitchenOrderData> orders;
  final Map<KitchenFilter, int> counts;
  final int total;

  const KitchenOrdersResponse({
    this.orders = const [],
    this.counts = const {},
    this.total = 0,
  });

  factory KitchenOrdersResponse.fromJson(dynamic json) {
    // Defensive: a proxy/HTML error body parses as not-a-map.
    if (json is! Map) return const KitchenOrdersResponse();
    final rawCounts = json['counts'];
    final counts = <KitchenFilter, int>{};
    if (rawCounts is Map) {
      for (final filter in KitchenFilter.values) {
        final value = rawCounts[filter.labelKey];
        if (value != null) {
          counts[filter] = int.tryParse('$value') ?? 0;
        }
      }
    }
    return KitchenOrdersResponse(
      orders: [
        for (final row in (json['orders'] as List? ?? const []))
          if (row is Map<String, dynamic>) KitchenOrderData.fromJson(row),
      ],
      counts: counts,
      total: int.tryParse('${json['total'] ?? 0}') ?? 0,
    );
  }
}
