# manager_app

A new Flutter project for the ROKCT Manager application.

<!-- @generated-store-description-start -->
<!-- @generated-store-description-end -->

<!-- @generated-tour-gallery-start -->
## App tour

Styled stills from the committed guided tour - regenerated on every
tour run, so new screens appear here automatically.

| Pos Scan | Pos Cart | Pos Checkout |
| :---: | :---: | :---: |
| ![Pos Scan][s05] | ![Pos Cart][s06] | ![Pos Checkout][s07] |
| **Pos Receipt Preview** | **Restaurant Hub** | **Sync Issues** |
| ![Pos Receipt Preview][s08] | ![Restaurant Hub][s09] | ![Sync Issues][s10] |
| **Quick Flow** | **Menu** | **Add Product** |
| ![Quick Flow][s11] | ![Menu][s12] | ![Add Product][s13] |
| **Product Detail** | **Quick Stock** | **Order Queue** |
| ![Product Detail][s14] | ![Quick Stock][s15] | ![Order Queue][s16] |
| **Order History** | **Order Pos Products** | **Order Pos Cart** |
| ![Order History][s17] | ![Order Pos Products][s18] | ![Order Pos Cart][s19] |
| **Order Pos Shipping** | **Order Pos Customer** | **Order Pos Section** |
| ![Pos Shipping][s20] | ![Pos Customer][s21] | ![Order Pos Section][s22] |
| **Order Pos Delivery Time** | **Order Loads** | **Order Issue Load** |
| ![Pos Delivery Time][s23] | ![Order Loads][s24] | ![Order Issue Load][s25] |
| **Order Shop Drivers** | **Kitchen Queue** | **Kitchen Detail** |
| ![Order Shop Drivers][s26] | ![Kitchen Queue][s27] | ![Kitchen Detail][s28] |
| **Comms Language** | **Comms Notifications** | **Revenue Income** |
| ![Comms Language][s29] | ![Notifications][s30] | ![Revenue Income][s31] |
| **Product Profit** | **Subscriptions Plans** | **Productivity Tasks** |
| ![Product Profit][s32] | ![Plans][s33] | ![Productivity Tasks][s34] |
| **Task Compose** | **Maintenance Readings** | **Maintenance Photo** |
| ![Task Compose][s35] | ![Readings][s36] | ![Maintenance Photo][s37] |
| **Productivity Plan** | **Productivity Mastery** | **Calc Keypad** |
| ![Productivity Plan][s38] | ![Mastery][s39] | ![Calc Keypad][s40] |

The full tour lives in the [feature guide](marketing/tour/feature-guide.md),
with walkthrough videos alongside it in [`marketing/tour/`](marketing/tour).

[s05]: marketing/tour/store/05-pos_scan.png
[s06]: marketing/tour/store/06-pos_cart.png
[s07]: marketing/tour/store/07-pos_checkout.png
[s08]: marketing/tour/store/08-pos_receipt_preview.png
[s09]: marketing/tour/store/09-restaurant_hub.png
[s10]: marketing/tour/store/10-sync_issues.png
[s11]: marketing/tour/store/11-quick_flow.png
[s12]: marketing/tour/store/12-menu.png
[s13]: marketing/tour/store/13-add_product.png
[s14]: marketing/tour/store/14-product_detail.png
[s15]: marketing/tour/store/15-quick_stock.png
[s16]: marketing/tour/store/16-order_queue.png
[s17]: marketing/tour/store/17-order_history.png
[s18]: marketing/tour/store/18-order_pos_products.png
[s19]: marketing/tour/store/19-order_pos_cart.png
[s20]: marketing/tour/store/20-order_pos_shipping.png
[s21]: marketing/tour/store/21-order_pos_customer.png
[s22]: marketing/tour/store/22-order_pos_section.png
[s23]: marketing/tour/store/23-order_pos_delivery_time.png
[s24]: marketing/tour/store/24-order_loads.png
[s25]: marketing/tour/store/25-order_issue_load.png
[s26]: marketing/tour/store/26-order_shop_drivers.png
[s27]: marketing/tour/store/27-kitchen_queue.png
[s28]: marketing/tour/store/28-kitchen_detail.png
[s29]: marketing/tour/store/29-comms_language.png
[s30]: marketing/tour/store/30-comms_notifications.png
[s31]: marketing/tour/store/31-revenue_income.png
[s32]: marketing/tour/store/32-revenue_product_profit.png
[s33]: marketing/tour/store/33-subscriptions_plans.png
[s34]: marketing/tour/store/34-productivity_tasks.png
[s35]: marketing/tour/store/35-productivity_task_compose.png
[s36]: marketing/tour/store/36-productivity_maintenance_readings.png
[s37]: marketing/tour/store/37-productivity_maintenance_photo.png
[s38]: marketing/tour/store/38-productivity_plan.png
[s39]: marketing/tour/store/39-productivity_mastery.png
[s40]: marketing/tour/store/40-calc_keypad.png
<!-- @generated-tour-gallery-end -->

<!-- @generated-render-strip-start -->
## Design review strip

[render-strip.html](marketing/tour/render-strip.html)
is one self-contained page of this app's real screens - rendered
headlessly from the code in this commit, before the tour's emulator
legs ran, with every point numbered from the widget's own measured
rectangle.

GitHub serves a committed .html file as source, so open it from a
local checkout (or download the raw file) to read the page.
<!-- @generated-render-strip-end -->

## Building & Release (CI/CD)

The project uses GitHub Actions for automated builds and releases. To enable signed builds, you must configure the following **Secrets** in your repository settings (`Settings > Secrets and variables > Actions`).

### 🔑 Required Secrets

#### 🤖 Android Secrets
*   `GOOGLE_SERVICES_JSON`: The **Base64 encoded** content of your `android/app/google-services.json`.
*   `KEY_JKS`: The **Base64 encoded** content of your release keystore file (`.jks`).
*   `KEY_PASSWORD`: The password for your keystore.
*   `ALIAS_PASSWORD`: The password for your key alias.
*   `PRODUCTION_ENV`: The **Base64 encoded** content of your `.env/production.env` file.

#### 🍎 iOS Secrets
*   `IOS_GOOGLE_SERVICE_INFO_PLIST`: The **Base64 encoded** content of `ios/Runner/GoogleService-Info.plist`.
*   `IOS_P12_BASE64`: The **Base64 encoded** `.p12` export of your Apple Distribution Certificate.
*   `IOS_MOBILEPROVISION_BASE64`: The **Base64 encoded** `.mobileprovision` file for your app.
*   `IOS_CERTIFICATE_PASSWORD`: The password used when exporting the `.p12` certificate.

---

### 🛠️ How to Encode Files
To provide the file contents as secrets, you must encode them to Base64 first. Use the following commands from the **root of your repository**:

**macOS/Linux:**
```bash
# For Android
base64 -i android/app/google-services.json | pbcopy

# For iOS
base64 -i ios/Runner/GoogleService-Info.plist | pbcopy

# For Production Environment
base64 -i .env/production.env | pbcopy
```

**Windows (PowerShell):**
```powershell
# For Android (Auto-Clip)
[Convert]::ToBase64String([IO.File]::ReadAllBytes("android/app/google-services.json")) | clip

# For iOS (Auto-Clip)
[Convert]::ToBase64String([IO.File]::ReadAllBytes("ios/Runner/GoogleService-Info.plist")) | clip

# For Production Environment (Auto-Clip)
[Convert]::ToBase64String([IO.File]::ReadAllBytes(".env/production.env")) | clip
```

Paste the resulting string into the corresponding GitHub Secret value.

### 🏗️ Multi-Tenant Build Support (build_* branches)
You can trigger dynamic builds for specific clients by creating a branch following the `build_<client>-*` pattern (e.g., `build_clientname-v1.0`).

The workflow will automatically look for client-specific secrets:
*   `GOOGLE_SERVICES_JSON_<CLIENT>`
*   `IOS_GOOGLE_SERVICE_INFO_PLIST_<CLIENT>`
*   `PRODUCTION_ENV_<CLIENT>`

If found, these will take precedence over the default secrets. The release candidate will also be tagged with the client suffix (e.g., `v1.0.0-clientname`).

### 📦 Change App Package
Firstly, find out the existing package name. You can find it out from top of `/app/src/main/AndroidManifest.xml` file. Then right click on project folder from android studio and click on **Replace in Path**. You will see a popup window with two input boxes. In first box you have to put existing package name that you saw in `AndroidManifest.xml` file previously and then write down your preferred package name in second box and then click on **Replace All** button.

<!-- @generated-recompose-start -->
## Recomposing this app

`lib/` is fully installer-generated and disposable - it is safe to delete
and is gitignored. Anything app-specific lives in tracked manifests
(`app_routes`, or `host_routes` in `composer.json`), never in `lib/` itself.

To regenerate it:

```sh
python3 .rokct/initiate.py   # provisions the composer under .rokct/skills/
python3 .rokct/skills/.rok/flutter/scripts/compose.py
```

Session cleanup (`python3 .rokct/end_protocol.py`) wipes the provisioned
tools again.
<!-- @generated-recompose-end -->
