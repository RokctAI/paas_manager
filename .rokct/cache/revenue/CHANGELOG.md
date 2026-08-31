## 1.6.0

* Manager income page REWRITTEN as the approved revenue/statistics
  dashboard with profitability (design section 36, chips 654–674 — Ray's
  2026-08-29 14:51Z requirement, approved 2026-08-30 10:38Z: 36a tablet
  workspace / 36b phone / 36c drill-down). The old manager income
  templates (app_bar_screen, chart, order_prices_section,
  statistics_section, statistics_item) predated the common wrap and did
  not compile; they are replaced by ONE template shell — all machinery
  now lives in analyzable, tested package code (`src/manager`):

  * `RevenueWorkspace` + `RevenuePlaneFlow`: the dashboard declares ALL
    planes (KPI column | revenue-vs-profit chart + status split |
    profit-by-product), the product drill-down pushes into the LAST
    plane and the origin compresses to the 36c mini-KPI rail; phones get
    the 36b single column with a REAL pushed detail route. The pushed
    detail folds the nav to the corner back pill (12:36Z); at top level
    the template shows the FULL centered floating nav with the Profile
    tab lit (the locked "workspace, not pushed page" decision) — a tab
    tap selects on mainProvider and pops to the shell.
  * Profit, as sold: `get_seller_profit_report` (merchants >= 1.15.0)
    consumed via the existing `api.seller_report` cmd path — Profit and
    Margin%-of-costed-revenue KPI tiles, profit line on the trend chart
    (drawn by a CustomPainter, no chart dependency), per-product
    profitability in the canonical 35a Price/Cost/Margin grammar with
    the "cost not set" state, and the amber unknown-cost bucket banner —
    cost_price <= 0 lines are excluded and NEVER counted as pure profit.
    Until that backend is deployed the dashboard degrades honestly: the
    payout strip and today-count still ride the shipped
    `get_order_report`, and the profit content shows a named error card
    with retry — no fake zeros (PRs mergeable in any order).
  * Ray's paas_pos grammar preserved: Today/Week/Month segments + custom
    date-range chip, vs-previous-period delta pills (computed by calling
    the endpoint for the shifted window), the Avg order card; his old
    revenue−expenses "Profit" card is superseded by the cost-based math
    he asked for. The shipped page's data preserved: payout strip
    (restaurantRevenue/fmRevenue made honest as gross → platform fee →
    payout), status split, "More about orders" → order history.
  * Drill-down (36c): full-size margin strip, window Sold/Revenue/Profit,
    per-variant margin rows (variant price against the product-level
    cost — the shipped schema has no per-variant cost; per-variant sold
    counts and the 7-day margin sparkline need per-product series and
    stay v2), the cost-frozen-at-sale note, and "Edit cost price"
    jumping into the 35b product edit form (`ProductEditPage.open`, the
    locked decision — no new form). The template resolves the product
    through the working seller products list call searched by title (the
    details endpoint's legacy param naming answers empty).
  * Manager tr_keys replaced with the section-36 vocabulary; the driver
    income templates and the legacy statistics slice
    (`src/manager/application/statistics`) are untouched
    (backward-compat rule). New dependency: `remixicon ^1.2.0`.
  * Tests: profit report parsing + honesty rules, window/delta math, and
    the 36a/36c plane claims (`test/`).

## 1.5.0

* Floating-nav back conversion (approved design strip section 12, "no
  double back buttons" — base_sdk 1.39.0 / core#125): the driver and
  manager income template pages replace their standalone `PopButton`
  with the shared `FloatingBottomNav` carrying only the leading back
  segment — one back per screen. The driver page's withdraw button
  rides in the same bottom overlay, above the pill. Back-only (empty
  tab list): the driver app composes no root tab set, and the manager
  template's pushed route cannot reach its host app's root tabs from
  this SDK.
