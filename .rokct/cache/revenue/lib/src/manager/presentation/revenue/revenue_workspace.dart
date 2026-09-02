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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

import 'package:base_sdk/src/presentation/adaptive/planes.dart';
import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/app_helpers.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/profit_report_response.dart';
import 'package:revenue_sdk/src/manager/application/profit/profit_dashboard_provider.dart';
import 'package:revenue_sdk/src/manager/application/profit/profit_dashboard_state.dart';
import 'package:revenue_sdk/src/manager/application/profit/revenue_period.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/kpi_tiles.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/payout_strip.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/product_profit_pane.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/profit_grammar.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/profit_product_list.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/revenue_detail_page.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/revenue_plane_flow.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/status_split_bar.dart';
import 'package:revenue_sdk/src/manager/presentation/revenue/trend_chart.dart';

/// The whole approved revenue dashboard body (frames 36a/36b/36c, Ray
/// 2026-08-30 10:38Z) — everything below the shell: fetch-on-mount, the
/// period windows, and the plane behaviour ([RevenuePlaneFlow]). The
/// income page template mounts exactly this widget and supplies the
/// host-router seams (order history, the 35b edit-cost jump, the foods
/// tab for "Set costs") as callbacks — this package never imports a host
/// router or a sibling SDK (ADR-005).
class RevenueWorkspace extends ConsumerStatefulWidget {
  /// Shop name beside the title, when the template knows it.
  final String? shopName;

  /// Chip 665 — "More about orders" → order history (group J).
  final VoidCallback? onOrderHistory;

  /// Chip 669's "Set costs" — the catalog, where costs are set in bulk.
  final VoidCallback? onSetCosts;

  /// Chip 674 — "Edit cost price" jumps into the 35b product edit form
  /// (the approved decision: the form, not a new surface).
  final void Function(BuildContext context, String productId)? onEditCost;

  /// Chip 672 — per-variant rows, loaded by the template through
  /// products_sdk when available.
  final List<ProductVariantView>? Function(String productId)? variantsFor;

  const RevenueWorkspace({
    super.key,
    this.shopName,
    this.onOrderHistory,
    this.onSetCosts,
    this.onEditCost,
    this.variantsFor,
  });

  @override
  ConsumerState<RevenueWorkspace> createState() => _RevenueWorkspaceState();
}

class _RevenueWorkspaceState extends ConsumerState<RevenueWorkspace> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profitDashboardProvider.notifier).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selected =
        ref.watch(profitDashboardProvider.select((s) => s.selectedProduct));
    return ColoredBox(
      color: AppStyle.surfaceDark,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // On a ONE-plane (phone) width the detail is a real pushed route
          // (RevenueDetailPage) — the flow hosts the dashboard alone there.
          final bool onePlane =
              PlaneHost.planeCountFor(constraints.maxWidth) == 1;
          return RevenuePlaneFlow(
            selectedProduct: onePlane ? null : selected,
            dashboardBuilder: (context) => _Dashboard(
              shopName: widget.shopName,
              onOrderHistory: widget.onOrderHistory,
              onSetCosts: widget.onSetCosts,
              onSelectProduct: (id) {
                ref
                    .read(profitDashboardProvider.notifier)
                    .selectProduct(id);
                if (PlaneHost.planeCountFor(
                        MediaQuery.sizeOf(context).width) ==
                    1) {
                  RevenueDetailPage.push(
                    context,
                    variantsFor: widget.variantsFor,
                    onEditCost: widget.onEditCost,
                  ).whenComplete(() {
                    ref
                        .read(profitDashboardProvider.notifier)
                        .selectProduct(null);
                  });
                }
              },
            ),
            detailBuilder: (context, product) => ProductProfitPane(
              product: product,
              variants: widget.variantsFor?.call(product.id),
              onEditCost: widget.onEditCost == null
                  ? null
                  : () => widget.onEditCost!(context, product.id),
            ),
            onCloseDetail: () =>
                ref.read(profitDashboardProvider.notifier).selectProduct(null),
          );
        },
      ),
    );
  }
}

/// The dashboard page itself — spreads its content over the planes it was
/// granted: 3 = KPI | chart | products (36a); 2 with the detail open = the
/// 36c compressed origin (mini-KPI rail | compact product list); 2 without
/// = [KPI + chart] | products; 1 = the 36b single scrolling column.
class _Dashboard extends ConsumerWidget {
  final String? shopName;
  final VoidCallback? onOrderHistory;
  final VoidCallback? onSetCosts;
  final void Function(String productId) onSelectProduct;

  const _Dashboard({
    required this.shopName,
    required this.onOrderHistory,
    required this.onSetCosts,
    required this.onSelectProduct,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profitDashboardProvider);
    final planes = Planes.maybeOf(context);
    final int span = planes?.span ?? 1;
    final bool compressed = span >= 2 && state.selectedProductId != null;

    if (span == 1) return _phoneColumn(context, ref, state);
    if (compressed) return _compressedOrigin(context, ref, state);
    return _spread(context, ref, state, span);
  }

  // ------------------------------------------------------------------ 36a
  Widget _spread(BuildContext context, WidgetRef ref,
      ProfitDashboardState state, int span) {
    final kpiColumn = ListView(
      padding: const EdgeInsets.only(bottom: 120),
      children: [
        ..._kpiTiles(state, paired: true),
        const SizedBox(height: 12),
        _payout(state),
      ],
    );
    final chartColumn = ListView(
      padding: const EdgeInsets.only(bottom: 120),
      children: [
        RevenueTrendChart(series: state.report?.series ?? const []),
        const SizedBox(height: 12),
        _statusBar(state, compact: false),
        const SizedBox(height: 12),
        _moreAboutOrders(),
        if (state.hasReportError) ...[
          const SizedBox(height: 12),
          _errorCard(ref),
        ],
      ],
    );
    final productsColumn = ListView(
      padding: const EdgeInsets.only(bottom: 120),
      children: [
        _productsHeader(),
        const SizedBox(height: 10),
        ..._productRows(state, compact: false),
        const SizedBox(height: 12),
        UnknownBucketBanner(
          bucket: state.report?.unknownBucket ?? const UnknownCostBucket(),
          onSetCosts: onSetCosts,
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _headerRow(context, ref, state, full: true),
          const SizedBox(height: 14),
          Expanded(
            child: span >= 3
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: kpiColumn),
                      const SizedBox(width: 14),
                      Expanded(child: chartColumn),
                      const SizedBox(width: 14),
                      Expanded(child: productsColumn),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.only(bottom: 120),
                          children: [
                            ..._kpiTiles(state, paired: true),
                            const SizedBox(height: 12),
                            RevenueTrendChart(
                              series: state.report?.series ?? const [],
                              height: 180,
                            ),
                            const SizedBox(height: 12),
                            _statusBar(state, compact: true),
                            const SizedBox(height: 12),
                            _moreAboutOrders(),
                            const SizedBox(height: 12),
                            _payout(state),
                            if (state.hasReportError) ...[
                              const SizedBox(height: 12),
                              _errorCard(ref),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: productsColumn),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------ 36c
  Widget _compressedOrigin(
      BuildContext context, WidgetRef ref, ProfitDashboardState state) {
    final totals = state.report?.totals;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _headerRow(context, ref, state, full: false),
          const SizedBox(height: 14),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 120),
                    children: [
                      KpiMiniList(rows: [
                        (
                          AppHelpers.getTranslation('revenue'),
                          totals == null
                              ? '—'
                              : AppHelpers.numberFormat(
                                  number: totals.revenue),
                          null,
                        ),
                        (
                          '${AppHelpers.getTranslation('profit')} '
                              '(${AppHelpers.getTranslation('as_sold')})',
                          totals == null
                              ? '—'
                              : AppHelpers.numberFormat(number: totals.profit),
                          AppStyle.green,
                        ),
                        (
                          AppHelpers.getTranslation('margin'),
                          totals == null
                              ? '—'
                              : formatPercent(totals.marginPct),
                          AppStyle.green,
                        ),
                        (
                          AppHelpers.getTranslation('orders'),
                          totals == null ? '—' : '${totals.orders}',
                          null,
                        ),
                        (
                          AppHelpers.getTranslation('avg_order'),
                          totals == null
                              ? '—'
                              : AppHelpers.numberFormat(
                                  number: totals.avgOrder),
                          null,
                        ),
                      ]),
                      const SizedBox(height: 12),
                      _statusBar(state, compact: true),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 120),
                    children: [
                      _productsHeader(),
                      const SizedBox(height: 10),
                      ..._productRows(state, compact: true),
                      const SizedBox(height: 12),
                      UnknownBucketBanner(
                        bucket: state.report?.unknownBucket ??
                            const UnknownCostBucket(),
                        onSetCosts: onSetCosts,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------ 36b
  Widget _phoneColumn(
      BuildContext context, WidgetRef ref, ProfitDashboardState state) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
      children: [
        _headerRow(context, ref, state, full: true, stacked: true),
        const SizedBox(height: 14),
        ..._kpiTiles(state, paired: true),
        const SizedBox(height: 12),
        RevenueTrendChart(
            series: state.report?.series ?? const [], height: 180),
        const SizedBox(height: 12),
        _statusBar(state, compact: true),
        const SizedBox(height: 12),
        _moreAboutOrders(),
        if (state.hasReportError) ...[
          const SizedBox(height: 12),
          _errorCard(ref),
        ],
        const SizedBox(height: 16),
        _productsHeader(),
        const SizedBox(height: 10),
        ..._productRows(state, compact: false),
        const SizedBox(height: 12),
        UnknownBucketBanner(
          bucket: state.report?.unknownBucket ?? const UnknownCostBucket(),
          onSetCosts: onSetCosts,
        ),
        const SizedBox(height: 12),
        _payout(state),
      ],
    );
  }

  // ------------------------------------------------------------- pieces
  Widget _headerRow(BuildContext context, WidgetRef ref,
      ProfitDashboardState state,
      {required bool full, bool stacked = false}) {
    final title = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppHelpers.getTranslation('revenue'),
          style: AppStyle.interBold(size: 24, color: AppStyle.textPrimary),
        ),
        if (shopName != null && shopName!.isNotEmpty) ...[
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              shopName!,
              style: AppStyle.interNormal(
                size: 13,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ),
        ],
      ],
    );
    if (!full) {
      // 36c compressed header: title + the collapsed window line.
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const SizedBox(height: 2),
          Text(
            _windowLabel(state),
            style: AppStyle.interNormal(
              size: 12,
              color: AppStyle.textDarkSecondary,
            ),
          ),
        ],
      );
    }
    final controls = PeriodControl(state: state);
    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: title),
              RangeChip(state: state),
            ],
          ),
          const SizedBox(height: 12),
          controls,
        ],
      );
    }
    return Row(
      children: [
        Expanded(child: title),
        controls,
        const SizedBox(width: 10),
        RangeChip(state: state),
      ],
    );
  }

  String _windowLabel(ProfitDashboardState state) {
    final window = RevenueWindow.of(
      state.period,
      DateTime.now(),
      customFrom: state.customFrom,
      customTo: state.customTo,
    );
    final format = DateFormat('d MMM');
    final label = switch (state.period) {
      RevenuePeriod.today => AppHelpers.getTranslation('today'),
      RevenuePeriod.week => AppHelpers.getTranslation('this_week'),
      RevenuePeriod.month => AppHelpers.getTranslation('this_month'),
      RevenuePeriod.custom => AppHelpers.getTranslation('custom_range'),
    };
    return '$label · ${format.format(window.from)} – '
        '${format.format(window.to)}';
  }

  List<Widget> _kpiTiles(ProfitDashboardState state, {required bool paired}) {
    final totals = state.report?.totals;
    final previous = state.previous?.totals;
    final bool loading = state.isLoading && totals == null;
    String money(num? value) =>
        value == null ? (loading ? '…' : '—') : AppHelpers.numberFormat(number: value);

    final revenue = RevenueKpiTile(
      label: AppHelpers.getTranslation('revenue'),
      value: money(totals?.revenue),
      sub: AppHelpers.getTranslation('vs_previous_period'),
      delta: totals != null && previous != null
          ? percentDelta(totals.revenue, previous.revenue)
          : null,
    );
    final profit = RevenueKpiTile(
      label: AppHelpers.getTranslation('profit'),
      value: money(totals?.profit),
      valueColor: AppStyle.green,
      sub: totals == null
          ? AppHelpers.getTranslation('as_sold')
          : '${AppHelpers.getTranslation('as_sold')} · '
              '${totals.ordersCosted} ${AppHelpers.getTranslation('of')} '
              '${totals.orders} ${AppHelpers.getTranslation('orders_costed')}',
      delta: totals != null && previous != null
          ? percentDelta(totals.profit, previous.profit)
          : null,
    );
    final margin = RevenueKpiTile(
      label: AppHelpers.getTranslation('margin'),
      value: totals == null ? (loading ? '…' : '—') : formatPercent(totals.marginPct),
      valueColor: AppStyle.green,
      sub: AppHelpers.getTranslation('of_costed_revenue'),
      delta: totals != null && previous != null
          ? pointDelta(totals.marginPct, previous.marginPct, hasBoth: true)
          : null,
      deltaInPoints: true,
    );
    final orders = RevenueKpiTile(
      label: AppHelpers.getTranslation('orders'),
      value: totals == null ? (loading ? '…' : '—') : '${totals.orders}',
      sub: state.payout?.totalTodayCount == null
          ? null
          : '${state.payout!.totalTodayCount} '
              '${AppHelpers.getTranslation('today')}',
      delta: totals != null && previous != null
          ? percentDelta(totals.orders, previous.orders)
          : null,
    );
    final avg = RevenueKpiTile(
      label: AppHelpers.getTranslation('avg_order'),
      value: money(totals?.avgOrder),
      sub: AppHelpers.getTranslation('vs_previous_period'),
      delta: totals != null && previous != null
          ? percentDelta(totals.avgOrder, previous.avgOrder)
          : null,
    );

    if (!paired) return [revenue, profit, margin, orders, avg];
    return [
      revenue,
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: profit),
          const SizedBox(width: 12),
          Expanded(child: margin),
        ],
      ),
      const SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: orders),
          const SizedBox(width: 12),
          Expanded(child: avg),
        ],
      ),
    ];
  }

  Widget _payout(ProfitDashboardState state) {
    final payout = state.payout;
    if (payout == null) return const SizedBox.shrink();
    return PayoutStrip(
      gross: payout.totalPrice ?? 0,
      payout: payout.fmTotalPrice ?? 0,
    );
  }

  Widget _statusBar(ProfitDashboardState state, {required bool compact}) {
    final report = state.report;
    if (report == null) return const SizedBox.shrink();
    return StatusSplitBar(
      counts: report.statusCounts,
      total: report.totals.orders,
      compact: compact,
    );
  }

  Widget _moreAboutOrders() {
    return Material(
      color: AppStyle.cardDark,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onOrderHistory,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppStyle.strokeDarkSubtle),
          ),
          child: Row(
            children: [
              Icon(Remix.file_list_3_line,
                  size: 18, color: AppStyle.textPrimary),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppHelpers.getTranslation('more_about_orders'),
                  style: AppStyle.interSemi(
                    size: 14,
                    color: AppStyle.textPrimary,
                  ),
                ),
              ),
              Text(
                AppHelpers.getTranslation('order_history'),
                style: AppStyle.interNormal(
                  size: 12,
                  color: AppStyle.textDarkSecondary,
                ),
              ),
              Icon(Remix.arrow_right_s_line,
                  size: 18, color: AppStyle.textDarkSecondary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productsHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            AppHelpers.getTranslation('profit_by_product'),
            style: AppStyle.interBold(size: 17, color: AppStyle.textPrimary),
          ),
        ),
        Text(
          AppHelpers.getTranslation('this_period'),
          style:
              AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
        ),
      ],
    );
  }

  List<Widget> _productRows(ProfitDashboardState state,
      {required bool compact}) {
    final report = state.report;
    if (report == null) {
      if (state.isLoading) {
        return const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: CircularProgressIndicator()),
          ),
        ];
      }
      return const [];
    }
    if (report.products.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              AppHelpers.getTranslation('no_data'),
              style: AppStyle.interNormal(
                size: 12,
                color: AppStyle.textDarkFaint,
              ),
            ),
          ),
        ),
      ];
    }
    return [
      for (final product in report.products)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ProductProfitRow(
            product: product,
            compact: compact,
            selected: product.id == state.selectedProductId,
            onTap: () => onSelectProduct(product.id),
          ),
        ),
    ];
  }

  /// Honest degradation until the backend ships (or the network fails):
  /// no fake zeros — the failure is named, with a retry.
  Widget _errorCard(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppStyle.strokeDark),
        color: AppStyle.cardDarkAlt,
      ),
      child: Row(
        children: [
          Icon(Remix.wifi_off_line,
              size: 18, color: AppStyle.textDarkSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              AppHelpers.getTranslation('profitability_could_not_be_loaded'),
              style: AppStyle.interNormal(
                size: 12,
                color: AppStyle.textDarkSecondary,
              ),
            ),
          ),
          InkWell(
            onTap: () => ref.read(profitDashboardProvider.notifier).fetch(),
            child: Text(
              AppHelpers.getTranslation('retry'),
              style: AppStyle.interSemi(size: 12, color: AppStyle.primary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Chip 654 — the Today / Week / Month segments (Ray's paas_pos
/// day/week/month + the shipped page's tabs, as dark segments).
class PeriodControl extends ConsumerWidget {
  final ProfitDashboardState state;

  const PeriodControl({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(profitDashboardProvider.notifier);
    Widget segment(RevenuePeriod period, String label) {
      final bool active = state.period == period;
      return InkWell(
        onTap: () => notifier.setPeriod(period),
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active ? AppStyle.white : null,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            label,
            style: AppStyle.interSemi(
              size: 13,
              color:
                  active ? AppStyle.blackColor : AppStyle.textDarkSecondary,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppStyle.cardDark,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppStyle.strokeDarkSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          segment(RevenuePeriod.today, AppHelpers.getTranslation('today')),
          segment(RevenuePeriod.week, AppHelpers.getTranslation('week')),
          segment(RevenuePeriod.month, AppHelpers.getTranslation('month')),
        ],
      ),
    );
  }
}

/// Chip 655 — Ray's custom date-range chip, preserved: calendar glyph +
/// the current window, tap opens the system range picker.
class RangeChip extends ConsumerWidget {
  final ProfitDashboardState state;

  const RangeChip({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final window = RevenueWindow.of(
      state.period,
      DateTime.now(),
      customFrom: state.customFrom,
      customTo: state.customTo,
    );
    final format = DateFormat('d MMM');
    return InkWell(
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(now.year - 2),
          lastDate: now,
          initialDateRange: DateTimeRange(start: window.from, end: window.to),
        );
        if (picked != null) {
          ref
              .read(profitDashboardProvider.notifier)
              .setCustomRange(picked.start, picked.end);
        }
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: AppStyle.cardDark,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppStyle.strokeDarkSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Remix.calendar_line,
                size: 15, color: AppStyle.textDarkSecondary),
            const SizedBox(width: 6),
            Text(
              '${format.format(window.from)} – ${format.format(window.to)}',
              style: AppStyle.interSemi(
                size: 12,
                color: AppStyle.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Remix.arrow_down_s_line,
                size: 14, color: AppStyle.textDarkSecondary),
          ],
        ),
      ),
    );
  }
}
