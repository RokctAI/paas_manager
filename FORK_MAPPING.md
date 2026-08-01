# paas_manager → SDK fork mapping (survey, pre-move)

> **RECONCILIATION APPENDED — see §6 at the end.** A cross-session update reported monorepo
> changes that partly invalidate this document and, more importantly, surfaced two SDKs
> (`revenue_sdk`, `zones_sdk`) that already contain forked paas_manager pages. §6 records what
> I verified on disk, what is stale here, and two contradictions that block moving code.


Branch: `fork/paas-manager-to-sdks` (paas_manager). No SDK repo has been branched or written to yet.
Source: `paas_manager/lib`, 645 `.dart` files.
Verified: `/api/v1` 89 hits vs `/api/method` 1 hit in `paas_manager/lib` — the app is entirely
Laravel-era, as stated.

Target shape = `paas_customer/lib`, which today is only `core/presentation/routes`,
`core/presentation/theme` and `main.dart`.

---

## 1. Mapping table

### base_sdk — USE what is there, delete the app's copy (Rule 4)

| paas_manager | base_sdk equivalent |
|---|---|
| `domain/handlers/*` (api_result, http_service, network_exceptions, token_interceptor, handlers) | `lib/src/handlers/*` — same files |
| `infrastructure/services/*` (app_assets, app_connectivity, app_helpers, app_validators, custom_scroll_behavior, enums, extension, img_service, local_storage, marker_image_cropper, storage_keys, time_service, tpying_delay, tr_keys) | `lib/src/services/*` |
| `presentation/styles/style.dart` (109 lines, raw `Color(...)` constants) | `lib/src/presentation/theme/app_style.dart` |
| `presentation/component/buttons/*`, `text_fields/*`, `loading/*`, `helper/*`, `extras/*`, `tab_bars/custom_tab_bar.dart`, `custom_checkbox`, `custom_toggle`, `title_icon`, `select_item`, `app_bar_bottom_sheet`, `common_app_bar`, `blur_wrap`, `no_data_info`, `size_item` | `lib/src/presentation/components/**` — all present |
| `presentation/pages/initial/{splash_page,no_connection_page}.dart` | `lib/src/presentation/pages/initial/**` |
| `presentation/pages/add_address.dart` | `components/add_address.dart` |
| `presentation/pages/main/widgets/bottom_navigator_item.dart` | `components/floating_nav/bottom_navigator_item.dart` |
| `infrastructure/models/data/**`, `request/**`, most of `response/**` | `lib/src/models/**` |
| `utils/excluded_product_ids.dart` | `lib/src/utils/excluded_product_ids.dart` |

Nothing is proposed to be *added* to base_sdk except TrKeys — see Ask #7.

### auth_sdk (shared with driver → `common/`, parameterised)

`application/auth/**` (login, sign_up, reset_password, confirmation) and its duplicate
top-level twins `application/{login,sign_up,reset_password,confirmation}` — auth_sdk
`common/application/auth/**` already has every one of these notifiers/states.
`presentation/pages/auth/**` (login_page + `widgets/login_modal.dart`, register_page,
register_confirmation_page, `reset/{reset_password,set_password}_page.dart`) — auth_sdk
`common/presentation/pages/auth/**` already has each.

**Nothing new goes in `manager/`.** The manager deltas are all parameters: logo/asset,
after-login route, "keep me logged in" toggle, demo-credential prefill, and a language
button in the app bar. → constructor params / injected config on the existing common pages.

### users_sdk (shared)

- `application/profile/**` → `common/application/profile/` (users_sdk has repositories only, no application layer yet).
- Customer lookup for the POS flow uses `searchUser` (already in `user_repository.dart`).
- Customer *creation* → see Ask #4.

### orders_sdk (shared → `manager/`)

- `application/main/orders/**` (new / accepted / ready / on_a_way / appbar), `application/order_details`, `application/order_cart`, `application/order_products/**`, `application/order/{create_order,order}`, `application/order/shipping/{address,delivery,payment,section,table,time,user}`
- `presentation/pages/main/orders/**` (orders_home_page, details modal, price_information, image_dialog, per-status bodies, no_orders)
- `presentation/pages/main/create_order/**` — the whole POS order builder
- `presentation/pages/order_history/*`
- `presentation/component/{orders_item.dart, list_items/order_item.dart, order_food_item.dart, order_product_item.dart, bodies/products_body.dart}`

Backend already exists: `merchants/frappe/src/api/seller_order/seller_order.py` →
`get_seller_orders`, `get_seller_order_details`, `update_seller_order_status`,
`get_seller_order_refunds`, `update_seller_order_refund`, `get_seller_reviews`.
(Note the endpoints live in the merchants Frappe app but are order-shaped — the Dart
repository is still orders_sdk's; that is not a cross-SDK import, just an HTTP path.)

### products_sdk

- `application/foods/**` (create/edit product, details, stocks, categories, units, filter), `application/main/foods/{addons/**, extras/**, tabs}`, `application/product/**`
- `presentation/pages/main/foods/**` (all create/edit/addons/extras/foods screens and modals)
- `presentation/pages/food/ingredient_page.dart` — products_sdk `common/` already has `w_ingredient.dart` / `ingredient_item.dart`; prefer those.
- `presentation/component/list_items/{food_item, food_category_item, food_stock_item, editable_food_stock_item, food_unit_item, size_item, selectable_addon_item, extras_item, group_extras_item, text_extras_item, category_tab_bar_item}`

Backend exists in full: `seller_product.py` (products, categories, brands, extra groups,
extra values, units, tags, `update_product_stocks`, `update_product_extras`,
`get_seller_products_paginate`, `get_product_details`).

### kitchen_sdk (currently an **empty** package — `lib/` does not exist, manifest `installs: []`)

- `application/foods/create/details/kitchens/**`, `application/foods/edit/details/kitchen/**`
- `presentation/.../create_food_kitchens_modal.dart`, `edit_food_kitchens_modal.dart`
- `presentation/component/list_items/food_kitchen_item.dart`

Backend: `seller_operations.py` → `get/create/update/delete_seller_kitchen`.
See Ask #9 on the products↔kitchen boundary.

### merchants_sdk (`home_sdk` for manager)

- `application/restaurant/**` (restaurant, working_days, income/statistics, income/today_orders)
- `presentation/pages/restaurant/**` (restaurant_page, edit_restaurant_modal, working_time_modal, sections_item, shop_page_banner, logout_button, logout_modal)
- `presentation/pages/income/**` (income_page, more_orders, app_bar_screen, widgets/{chart, statistics_item, statistics_section, order_prices_section})
- `presentation/pages/become_seller/become_seller.dart` (`shops_repository.createShop` already exists)
- `presentation/component/helper/shop_bordered_avatar.dart`, `list_items/shop_tab_bar_item.dart`
- Sections & tables data (`application/order/shipping/{section,table}`) — see Ask #10

Backend: `seller_shop.py`, `seller_shop_settings.py`, `seller_reports.py`, `seller_report.py`,
`seller_operations.py`, `seller_transactions.py`.

### map_sdk (shared)

- `application/map/**` and `presentation/pages/view_map/{view_map_page,map_search_page}.dart` are **duplicates** of map_sdk `common/presentation/pages/view_map/*` — discard the app's.
- `presentation/pages/main/create_order/shipping/address/*` — address picking; base_sdk already has `sellect_address_screen.dart` / `select_address_item.dart`.
- `delivery_zone` — see Ask #8.

### comms_sdk (shared)

- `application/notification/**` + `presentation/pages/restaurant/notification_list_page.dart` → comms_sdk already has `notification_page.dart`; parameterise.
- `application/auth/login/languages/**` + `presentation/pages/auth/login/widgets/languages_modal.dart` → comms_sdk `language_page.dart`; manager wants it as a modal, customer as a page → one implementation, presentation mode as a parameter.
- settings / translations / currencies repositories already exist here.

### payments_sdk

- `application/order/shipping/payment/**`, `presentation/.../shipping/details/widgets/payment_item.dart` → `getPayments` and `createTransaction` already exist in `payments_repository.dart`.

### SDKs that receive **nothing** from paas_manager

`promotions_sdk` (no banner/story management UI in the app, although `seller_marketing.py`
exists backend-side), `subscriptions_sdk` (only a `subscription` field on `shop_data`; its
`templates/pages/subscriptions/` can simply be mounted by the shell), `corporate_sdk` (no
policy/term screens), `processing_sdk`, `productivity_sdk`, `hardware_sdk` (grep for
printer/bluetooth/esc_pos/scanner in `paas_manager/lib` returns nothing outside `water/`).

### Stays in the shell (`paas_manager/lib`)

`main.dart`, `presentation/app_widget.dart`, `presentation/app_assets.dart`,
`presentation/routes/app_router.dart(.gr.dart)`, `presentation/pages/main/main_page.dart`
(bottom-nav composition), `application/providers/app_providers.dart`,
`utils/app_initializer{,_widget}.dart`, `domain/di/{dependency_manager,injection}.dart`,
`app_constants.dart` — plus the cross-SDK adapters ADR-005 requires, in `templates/`.

### Discarded outright

- `infrastructure/repositories/**` — all 10 repositories are Laravel `/api/v1`. Rule 3.
- `domain/interface/**` — the Laravel repository contracts they serve.
- Dead response models, confirmed zero references anywhere in `lib`:
  `employee_response`, `employee_form_data_response`, `invoice_response`,
  `invoice_form_data_response`, `project_response`, `project_form_data_response`,
  `milestone_response`, `lead_response`, `quote_response`, `expense_response`,
  `deal_response`, `leave_response`, `bill_response`.

---

## 2. UNPLACED — needs an owner decision before anything moves

1. **`calc/`** (8 files). A calculator, with *two* parallel implementations: `calc/main.dart`
   (`CalculatorPage`, StatefulWidget, its own history/memory) and
   `calc/presentation/pages/calculator_widget.dart` (`CalculatorWidget`, riverpod +
   `calculator_provider` + freezed state). **Completely unwired** — no route, and no file
   outside `calc/` imports it. `TrKeys.calculator` exists, so it was meant to be a POS-side
   till calculator. Fits no SDK on the list. Options: `hardware_sdk/common/` (POS device
   tooling), or delete. Asking rather than guessing.
2. **`water/`** (13 files). Water-meter reading: `google_ml_kit` OCR of a meter face
   (hardcoded meter id regex `\b211090986\b`), a multi-step check-in flow, store info,
   consumption chart, recent readings, SharedPreferences persistence, and a POST to
   `${AppConstants.baseUrl}/api/v1/rest/water`. **Also unwired** — one commented-out import in
   `main_page.dart`, one model re-exported from `models.dart`. No Frappe counterpart exists
   anywhere in the SDK family. Fits no SDK. If it is kept, only the camera/OCR half has a
   home (`hardware_sdk/common/camera`); the domain itself does not.
3. **`generate_image/`** (application + page, route `/generate_image` is **live**). AI
   product-image generation, `getGenerateImage(String name)` against Laravel. No Frappe
   method for it in any SDK (`grep generate_image` over all `*.py` finds only unrelated ROK
   plugin code). Drop the feature, or is there a backend I have not found?

## 3. Coverage flags — SDK Frappe method may not cover what the Laravel call did

4. **`createUser`** — the POS "create a walk-in customer" modal.
   `seller_customer_management.py` exposes only `get_seller_request_models` and
   `get_seller_customer_addresses`. `users/frappe` has `register_user`, but that is the
   self-signup path, not a seller creating a customer. No seller-scoped create.
5. **Tables / sections / bookings gaps.** `seller_operations.py` has
   `get_seller_sections`, `create_seller_section`, `get_seller_tables`,
   `delete_seller_tables`, `get_table_disable_dates`, `get_booking_working_days`,
   `create_seller_booking`, `update_booking_status`. The app additionally calls
   `createNewTable`, `deleteSection`, `getTableInfo`, `getTableOrders`, `getStatistic`
   (table statistics) and `getCloseDay`. `seller_shop_settings.py` covers closed days
   (`get_seller_shop_closed_days`); the other five have no visible equivalent.
6. **POS cart calculation.** The app calls `getCalculate` and `getProductsCalculation`.
   orders_sdk has `getCalculate`, products_sdk has `getProductCalculations` /
   `getAllCalculations` — customer-cart shaped. Whether they accept a seller-side
   (shop-scoped, staff-authored) cart is unverified; I did not port the Laravel version.

## 4. Convention decisions I want confirmed

7. **TrKeys.** 258 keys in the manager's `tr_keys.dart`; **152 are absent from base_sdk's**
   (`acceptedOrders`, `deliveryZone`, `kitchens`, `swipeToReady`, `restaurantSettings`,
   `waiter`, `sku`, `stocks`, `takeAway`, … full list in the survey). There is no per-SDK
   TrKeys mechanism — no manifest declares `tr_keys`, and every key lives in base_sdk's
   single `tr_keys.dart`. So honouring the no-hardcoded-strings rule requires adding all 152
   to base_sdk, which every app in the family then inherits. Rule 4 says ask first — asking.
8. **Delivery zone placement.** `delivery_zone_page.dart` + `application/restaurant/delivery_zone/**`
   is a polygon-drawing map screen over merchant-owned data
   (`seller_delivery_zone.py`). map_sdk owns map screens and `draw_repository.dart`;
   merchants_sdk owns the data. ADR-005 forbids one importing the other. Proposal:
   the whole feature in `merchants_sdk/manager/` using `google_maps_flutter` directly
   (a pub package, not an SDK), leaving map_sdk untouched. Confirm, or prefer
   `map_sdk/manager/` + a zone-repository interface injected by the shell.
9. **Kitchen picker placement.** The kitchen list is only ever used *inside* the product
   create/edit form. Proposal: kitchen_sdk owns the `Kitchen` entity and repository;
   products_sdk's form declares a narrow `KitchenPicker` interface in its own
   `domain/interface/` and the shell adapts kitchen_sdk to it (ADR-005 pattern). The cheaper
   alternative is putting kitchens in products_sdk and leaving kitchen_sdk for
   cook/receipt/waiter screens only. Confirm which.
10. **Sections/tables in the POS flow.** Same shape: merchants_sdk owns the data
    (`seller_operations`), orders_sdk owns the screens (`select_section_page`,
    `select_table_page`). Proposal: interface in orders_sdk `domain/interface/`, adapter in
    the shell's `templates/`. Confirm.

## 5. Offline / Drift status (asked explicitly)

Of the 16 destination SDKs, exactly **three** declare tables in `manifest.json`:

| SDK | Tables | Migration version |
|---|---|---|
| auth_sdk | `OfflineUsersTable` | 16 |
| subscriptions_sdk | `UserSubscriptionsTable` | 15 |
| productivity_sdk | `TasksTable`, `RecoveryProfilesTable`, `AvoidedHabitsTable`, `UrgeLogsTable`, `DailyRitualsTable`, `RitualLogsTable`, `ProcrastinationLogsTable` | 13 / 14 |

base_sdk owns the `AppDatabase` and a generic `KeyValueTable` but declares no feature tables.
**No tables at all** in: merchants_sdk, products_sdk, orders_sdk, kitchen_sdk, comms_sdk,
users_sdk, map_sdk, payments_sdk, promotions_sdk, corporate_sdk, processing_sdk,
hardware_sdk.

So the fork does **not** make paas_manager offline-first for its own data (orders, products,
shop settings, income). It gains base_sdk's `AppDatabase` plumbing and offline auth; nothing
else. Per SDK_README that is "unfinished", not unsafe.

One correction to a cited example: SDK_README's offline section points at
`products_sdk`'s `searchProducts()` / `upsertProduct()` as the existing correct
live-fetch-with-Drift-fallback pattern. In `commerce/products/dart/lib` today there is no
`upsertProduct`, no `AppDatabase` reference and no Drift import at all — `searchProducts` is
a plain HTTP call. The pattern is not currently wired in products_sdk.

---

## 6. Reconciliation with the 2026-07-31 monorepo update

Everything below was checked on disk, not taken on report.

### Confirmed true, and what it changes here

| Claim | Verified | Effect on §1–5 |
|---|---|---|
| Feature SDKs wrapped under `lib/src/common/` | Yes. `processing_sdk` was `lib/src/application/...` when I surveyed earlier today and is now `lib/src/common/application/...` — it moved mid-session. | No mapping change; §1 already targeted `common/`. |
| `base_sdk` and `desktop_sdk` deliberately not wrapped | Yes — `base_sdk` is still `lib/src/{services,presentation,models,...}`; `desktop_sdk` is `lib/src/pos/di` only. | §1's base_sdk paths stay as written. |
| `core/` dropped from install destinations; `ROUTER_FILE` = `lib/presentation/routes/app_router.dart` | Yes — `core/utils/flutter/sdk_installer_base.py:10`. | The "target shape = `paas_customer/lib/core/...`" line at the top of this doc is **stale**. Target is `lib/presentation/...`. paas_customer has not been re-composed to the new layout yet. |
| `.rokct/config/app_type` required, `resolve_app_type()` returns None if absent | Yes — `sdk_installer_base.py:26`. | **Done:** created `paas_manager/.rokct/config/app_type` containing `manager`. Note that *no SDK currently in `manager.json` has an `app_type` block*, so today the file is inert — it matters once manager-flavor installs land, which this fork will add. |
| `AppRoutes` seam for SDK-internal navigation | Yes. | Adopted for all `manager/` pages. |
| `ProductDetailSheet` seam in base_sdk, nothing registers it | Yes — `core/base/dart/lib/src/domain/interface/product_detail_sheet.dart:25`. | Shell must register it if products_sdk pages are composed. |

### Not applicable

- **Stale `.rokct/sdk_installer_base.py` / `compose.py`.** paas_manager has no `.rokct/compose.py` and no `.rokct/config/` at all — it has never been composed. Neither have paas_customer, paas_driver or paas_pos. The compose.py overwrite bug can't have affected it.
- **`desktop_sdk` in `manager.json`.** paas_manager has zero printer/bluetooth/esc_pos/scanner usage anywhere in `lib` outside `water/`. It appears in `pos.json` only, which looks right.

### CONTRADICTION 1 — manager's income pages are already forked, into an SDK no app composes

`corporate/revenue/dart/templates/pages/manager/income/` contains six files that are a
port of `paas_manager/lib/presentation/pages/income/` (income_page, app_bar_screen,
widgets/{chart, statistics_item, statistics_section, order_prices_section}) — the exact set
§1 mapped to merchants_sdk. Its manifest gates them behind `app_type.manager`.

But `revenue_sdk` appears in **zero** composer templates — not `manager.json`, not any other.
And the templates do not compile against the current monorepo:

- they import `package:merchants_sdk/src/presentation/component/components.dart`,
  `src/presentation/pages/income/...` and `src/application/providers.dart`. merchants_sdk has
  **no** `src/presentation`, **no** `src/application` — only `src/common/{di,infrastructure,presentation/pages/shop}`.
- they import `package:${package}/core/presentation/theme/theme.dart` — the old pre-`core/`-drop path.

So this is a half-landed earlier fork: the leaf pages were staged into revenue_sdk against a
merchants_sdk trunk that was never populated, before both the `common/` wrap and the `core/`
drop. **Blocking question:** does the income feature belong in `revenue_sdk` (then it must be
added to `manager.json`, which Rule 1 says is already decided and closed), or in
`merchants_sdk` per §1 (then revenue_sdk's manager templates are dead and should be deleted)?
I will not guess, and I will not populate `merchants_sdk/src/presentation/...` just to satisfy
imports in an SDK nothing composes.

### CONTRADICTION 2 — same shape for the delivery-zone page

`zones/zones/dart/templates/pages/manager/merchant/delivery_zone/delivery_zone_page.dart`
exists under `app_type.manager`, and `zones_sdk` **is** in `driver.json` but **is not** in
`manager.json`. Its manager template has the same two defects: it imports
`package:merchants_sdk/src/application/providers.dart` (nonexistent) and
`package:${package}/core/presentation/theme/theme.dart` (old path).

This directly answers Ask #8 with an option §1 did not have: a third SDK. But it cannot fire
for paas_manager as configured. **Blocking question:** add `zones_sdk` to `manager.json`, or
keep delivery zone in `merchants_sdk/manager/` per §1 and drop the zones_sdk manager template?

Note this also collides with the driver session: `zones_sdk` is a driver SDK, and its
`app_type.driver` block installs a driver delivery-zone page. If zones_sdk becomes shared,
it joins the seven-SDK collision list and the `manager/` rule applies there too.

### Consequence for Ask #1/#2 (`calc/`, `water/`)

`booking_sdk` (`commerce/booking`) and `weather_sdk` (`zones/weather`) also exist and are not
in `manager.json`. This weakens my "fits no SDK on the list" framing: the list may simply be
narrower than the SDK set. `calc/` and `water/` still fit none of the 20+ SDKs I can see, so
the ask stands — but the right question is now "which composer template should paas_manager
actually use", not only "which of these 16".

---

## 7. Second reconciliation — owner rulings, and a fourth instance of the same pattern

### Rulings folded in

- **Routes (ruling 4).** No flavor-specific methods added to base_sdk's `AppRoutes`. Every
  manager page this fork produces gets routed by its owning SDK via manifest `routes` + an
  installed `*_route_pages.dart` template; SDK-internal `lib/src/` navigation goes through a
  per-SDK GetIt seam (the `ProductDetailSheet` / `LaunchGlanceSource` pattern), so apps
  without those pages simply never register it. This **supersedes** §6's line "Adopted
  `AppRoutes` seam for all `manager/` pages" — that would have meant widening a
  customer-flavoured seam, which is exactly what the ruling forbids.
- **Colors (ruling 5).** Manager brand values go through `AppStyle.injectBrandColors(...)`
  from the installed theme shim, not new tokens. This removes any base_sdk colour addition
  from my ask list. `AppStyle.primary` being `static const` and non-injectable is noted as
  out of scope for this fork.
- **`app_type` markers.** paas_customer / paas_driver / paas_pos now have committed markers;
  supacharge already had one (`supacharge`), so flavors are not limited to
  customer/driver/manager/pos. Mine stays untracked on this branch until the fork commits.

### CONTRADICTION 3 — `become_seller` is the same story again

Ruling 6 says `become_seller` / `become_driver` are flavor-specific entry points onto one
concept. Checked on disk, and it lands in the same trap as income and delivery zone:

| Feature | Already lives in | That SDK is composed by |
|---|---|---|
| income pages | `revenue_sdk` | **nothing** |
| manager delivery zone | `zones_sdk` | `driver.json` only |
| become_seller (`create_shop.dart`) | `marketplace_sdk` | `customer.json` only |
| become_driver | `delivery_sdk` | `customer.json`, `driver.json`, `launch_deliver.json` |

`merchants_sdk`, by contrast, is composed by `customer.json`, `launch_manager.json`,
`manager.json`, `pos.json` and `supacharge.json`.

And the two become_seller implementations are the same page, diverged:
`paas_manager/lib/presentation/pages/become_seller/become_seller.dart` (957 lines) and
`marketplace_sdk`'s `create_shop.dart` (595 lines) both declare `class CreateShopPage extends
ConsumerStatefulWidget` with private state `_EditRestaurantState`. Under Rule 5 that is one
parameterised implementation, not two — but they currently sit in two SDKs, only one of which
paas_manager composes.

### What this adds up to

Three of the four manager-relevant features that were *already* forked landed in SDKs
`manager.json` does not list. That is a consistent pattern across three separate repos and
two different dates, which makes it much more likely that **`manager.json`'s SDK list is the
stale artifact**, not the placement decisions — sharpening the "which composer template
should paas_manager use" question already with the owner. `launch_manager.json` exists and
carries the same core sixteen plus `launch_sdk`/`weather_sdk`, so it is not the answer either.

Also worth stating plainly: **whichever way income is decided, `revenue_sdk`'s manager
templates must be rewritten for post-`common/`-wrap imports and the post-`core/`-drop theme
path. They cannot be installed as-is under either option.**

### What is NOT blocked by any of this

Placement for these is identical under `manager.json` and `launch_manager.json`, so it does
not depend on the composer answer and can start on a green light:

- **base_sdk dedup** — delete the app's duplicate handlers/services/components/theme (§1).
- **auth_sdk** — parameterise existing `common/` pages; nothing new under `manager/`.
- **products_sdk** — foods/addons/extras/stocks/units/categories vertical slice.
- **orders_sdk `manager/`** — order queues, order details, order history, POS order builder.
- **kitchen_sdk** — the empty package gets its first content.

Blocked until the owner rules: income, delivery zone, become_seller, and the composer list.
