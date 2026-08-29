# manager_app

A new Flutter project for the ROKCT Manager application.

## App tour

<table>
  <tr>
    <td align="center"><img src="marketing/tour/screenshots/01-welcome.png" width="230" alt="Welcome screen"><br><sub>Welcome</sub></td>
    <td align="center"><img src="marketing/tour/screenshots/02-auth_login.png" width="230" alt="Login screen"><br><sub>Sign in</sub></td>
    <td align="center"><img src="marketing/tour/screenshots/03-auth_register.png" width="230" alt="Register screen"><br><sub>Create an account</sub></td>
  </tr>
</table>

The full tour lives in the [feature guide](marketing/tour/feature-guide.md), with walkthrough videos alongside it in [`marketing/tour/`](marketing/tour).

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
