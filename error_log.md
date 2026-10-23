# 🤖 Android Build Errors

The following syntax errors were found during the build process:

## `lib/presentation/pages/subscriptions/subscriptions_page.dart`
- subscriptionsGuide is not a class element
- package:manager/presentation/pages/subscriptions/subscriptions_page.dart:66:23
- ╷
- 66 │ const GuideDefinition subscriptionsGuide = GuideDefinition(
- │                       ^^^^^^^^^^^^^^^^^^
- ╵


## Failure record

| Field | Value |
|---|---|
| Failure class | `build` |
| SDK | _unknown_ |
| SDK version | _unknown_ |
| Consumer | `RokctAI/paas_manager` |
| Commit | `56764793b8d9f724fc4191bd529d6855409ab1ea` |
| Workflow / job | `Build (Smart) / build-android` |
| Stage | `dependencies` |
| API cmd | _unknown_ |
| Screenshot artifact | _unknown_ |
| Runner | `Linux, X64, ubuntu24, 20261012.334.1` |
| Run | https://github.com/RokctAI/paas_manager/actions/runs/39960305979 |

### Composed SDKs

| SDK | Installed version | Source | Ref |
|---|---|---|---|
| `base_sdk` | `1.93.0` | `https://github.com/RokctAI/core` | `main` |
| `auth_sdk` | `1.22.1` | `https://github.com/RokctAI/Users` | `main` |
| `users_sdk` | `1.5.2` | `https://github.com/RokctAI/Users` | `main` |
| `merchants_sdk` | `1.36.1` | `https://github.com/RokctAI/commerce` | `main` |
| `products_sdk` | `1.12.8` | `https://github.com/RokctAI/commerce` | `main` |
| `orders_sdk` | `1.31.1` | `https://github.com/RokctAI/commerce` | `main` |
| `kitchen_sdk` | `1.5.4` | `https://github.com/RokctAI/commerce` | `main` |
| `hardware_sdk` | `1.1.1` | `https://github.com/RokctAI/hardware` | `main` |
| `desktop_sdk` | `1.2.2` | `https://github.com/RokctAI/hardware` | `main` |
| `payments_sdk` | `1.3.6` | `https://github.com/RokctAI/pay` | `main` |
| `subscriptions_sdk` | `1.7.2` | `https://github.com/RokctAI/agent` | `main` |
| `comms_sdk` | `1.23.2` | `https://github.com/RokctAI/core` | `main` |
| `telemetry_sdk` | `1.1.0` | `https://github.com/RokctAI/core` | `main` |
| `processing_sdk` | `1.0.2` | `https://github.com/RokctAI/productivity` | `main` |
| `productivity_sdk` | `1.9.2` | `https://github.com/RokctAI/productivity` | `main` |
| `calc_sdk` | `1.4.1` | `https://github.com/RokctAI/productivity` | `main` |
| `corporate_sdk` | `1.2.0` | `https://github.com/RokctAI/corporate` | `main` |
| `promotions_sdk` | `1.4.1` | `https://github.com/RokctAI/commerce` | `main` |
| `booking_sdk` | `1.2.2` | `https://github.com/RokctAI/commerce` | `main` |
| `map_sdk` | `1.5.1` | `https://github.com/RokctAI/zones` | `main` |
| `weather_sdk` | `1.6.2` | `https://github.com/RokctAI/zones` | `main` |
| `revenue_sdk` | `1.14.2` | `https://github.com/RokctAI/corporate` | `main` |
| `zones_sdk` | `1.7.0` | `https://github.com/RokctAI/zones` | `main` |
| `hms_sdk` | `1.1.0` | `https://github.com/RokctAI/hardware` | `main` |

### Error summary

`E auto_route_generator on lib/presentation/pages/subscriptions/subscriptions_page.dart:`

<details><summary>Log tail</summary>

````
  firebase_auth 5.7.0 (7.0.1 available)
  firebase_auth_platform_interface 7.7.3 (9.1.2 available)
  firebase_auth_web 5.15.3 (6.3.2 available)
  firebase_core 3.15.2 (5.1.0 available)
  firebase_core_platform_interface 6.0.3 (8.1.1 available)
  firebase_core_web 2.24.1 (4.1.0 available)
  firebase_messaging 15.2.10 (17.0.1 available)
  firebase_messaging_platform_interface 4.6.10 (4.11.1 available)
  firebase_messaging_web 3.10.10 (4.3.1 available)
  firebase_remote_config 5.5.0 (7.0.1 available)
  firebase_remote_config_platform_interface 2.0.0 (3.0.9 available)
  firebase_remote_config_web 1.8.9 (1.10.16 available)
  fixnum 1.1.0 (1.1.1 available)
  fl_chart 0.69.0 (1.3.0 available)
  flutter_advanced_switch 3.1.0 (3.2.1 available)
  flutter_app_group_directory 1.1.0 (2.0.0 available)
  flutter_cache_manager 3.4.1 (3.4.5 available)
  flutter_facebook_auth 7.1.0 (7.2.0 available)
  flutter_launcher_icons 0.14.1 (0.14.4 available)
  flutter_lints 5.0.0 (6.0.0 available)
  flutter_local_notifications 19.5.0 (22.3.2 available)
  flutter_local_notifications_linux 6.0.0 (8.0.2 available)
  flutter_local_notifications_platform_interface 9.1.0 (12.2.0 available)
  flutter_local_notifications_windows 1.0.3 (3.1.1 available)
  flutter_native_splash 2.4.4 (2.4.8 available)
  flutter_plugin_android_lifecycle 2.0.23 (2.0.35 available)
  flutter_pos_printer_platform_image_3_sdt 1.2.12 (1.2.31 available)
  flutter_riverpod 2.6.1 (3.4.3 available)
  flutter_secure_storage 9.2.4 (11.2.0 available)
  flutter_secure_storage_linux 1.2.3 (3.0.3 available)
  flutter_secure_storage_macos 3.1.3 (4.0.0 available)
  flutter_secure_storage_platform_interface 1.1.2 (2.1.1 available)
  flutter_secure_storage_web 1.2.1 (2.1.1 available)
  flutter_secure_storage_windows 3.1.2 (4.2.2 available)
  freezed 3.2.5 (4.0.3 available)
  frontend_server_client 4.0.0 (4.2.0 available)
  geocoding 3.0.0 (5.0.0 available)
  geocoding_android 3.3.1 (5.1.0 available)
  geocoding_ios 3.0.1 (3.1.0 available)
  geocoding_platform_interface 3.2.0 (5.0.0 available)
  geolocator 13.0.4 (14.1.2 available)
  geolocator_android 4.6.1 (5.2.1 available)
  geolocator_apple 2.3.14 (2.4.3 available)
  geolocator_platform_interface 4.2.4 (4.4.1 available)
  geolocator_windows 0.2.3 (0.2.5 available)
! get_it 8.0.0 (overridden) (9.3.0 available)
  glob 2.1.3 (2.2.0 available)
! google_fonts 6.3.3 (overridden) (9.0.0 available)
  google_maps 8.1.1 (8.3.0 available)
  google_maps_flutter 2.9.0 (2.19.0 available)
  google_maps_flutter_android 2.14.8 (2.21.0 available)
  google_maps_flutter_ios 2.13.0 (2.18.7 available)
  google_maps_flutter_platform_interface 2.9.5 (2.17.0 available)
  google_maps_flutter_web 0.5.10 (0.6.5 available)
  google_sign_in 6.2.2 (7.2.0 available)
  google_sign_in_android 6.1.35 (7.2.18 available)
  google_sign_in_ios 5.9.0 (6.3.8 available)
  google_sign_in_platform_interface 2.5.0 (3.1.0 available)
  google_sign_in_web 0.12.4+4 (1.1.3 available)
! html 0.15.6 (overridden) (0.15.7 available)
! http 1.2.2 (overridden) (1.6.0 available)
  http_multi_server 3.2.1 (3.2.3 available)
  http_parser 4.0.2 (4.1.2 available)
  image 4.10.1 (4.12.0 available)
  image_cropper 8.1.0 (13.0.0 available)
  image_cropper_for_web 6.1.0 (8.0.1 available)
  image_cropper_platform_interface 7.2.0 (9.0.0 available)
  image_picker 1.1.2 (1.2.4 available)
  image_picker_android 0.8.12+15 (0.8.13+25 available)
  image_picker_for_web 3.0.5 (3.1.1 available)
  image_picker_ios 0.8.12 (0.8.13+13 available)
  image_picker_linux 0.2.1+1 (0.2.2 available)
  image_picker_macos 0.2.1+1 (0.2.2+1 available)
  image_picker_platform_interface 2.10.0 (2.11.2 available)
  image_picker_windows 0.2.1+1 (0.2.2 available)
! intl 0.20.3 (overridden)
  io 1.0.4 (1.1.0 available)
  jiffy 6.3.1 (6.4.5 available)
  js 0.6.7 (0.7.2 available)
  json_annotation 4.9.0 (4.12.0 available)
  lean_builder 0.1.5 (1.2.2 available)
  lints 5.0.0 (6.1.0 available)
  live_activities 2.4.3 (2.6.0 available)
  location 7.0.0 (10.0.2 available)
  location_platform_interface 5.0.0 (7.0.0 available)
  location_web 5.0.4 (7.0.0 available)
  lottie 3.3.3 (3.6.1 available)
  matcher 0.12.17 (0.12.20 available)
  material_color_utilities 0.11.1 (0.13.1 available)
  meta 1.17.0 (1.19.0 available)
  mime 1.0.6 (2.1.0 available)
  mobile_scanner 6.0.11 (7.4.2 available)
  network_info_plus 6.1.4 (8.2.2 available)
  network_info_plus_platform_interface 2.0.2 (3.1.0 available)
  nm 0.5.0 (0.6.0 available)
  octo_image 2.1.0 (2.1.2 available)
  osm_nominatim 3.0.1 (4.0.1 available)
  package_config 2.2.0 (3.0.0 available)
  package_info_plus 8.3.1 (10.2.2 available)
  package_info_plus_platform_interface 3.2.1 (4.1.0 available)
  path_parsing 1.0.1 (1.1.0 available)
  path_provider_android 2.2.12 (2.3.1 available)
  path_provider_foundation 2.4.0 (2.6.0 available)
  path_provider_linux 2.2.1 (2.2.2 available)
  path_provider_platform_interface 2.1.2 (2.1.3 available)
! permission_handler 12.0.3 (overridden) (13.0.2 available)
  permission_handler_android 13.0.1 (14.1.0 available)
  permission_handler_apple 9.4.7 (9.6.4 available)
  permission_handler_html 0.1.3+5 (0.1.4+1 available)
  permission_handler_platform_interface 4.3.0 (4.4.1 available)
  permission_handler_windows 0.2.1 (0.2.2 available)
  petitparser 6.0.2 (7.1.0 available)
  pin_input_text_field 4.5.2 (4.5.3 available)
  platform 3.1.5 (3.2.0 available)
  pool 1.5.1 (1.5.3 available)
  print_bluetooth_thermal 1.2.1 (1.2.5 available)
  process 5.0.5 (5.0.6 available)
  pub_semver 2.2.0 (2.2.1 available)
  pubspec_parse 1.3.0 (1.7.0 available)
  qr 3.0.2 (4.0.0 available)
  remixicon 1.4.1 (4.9.3 available)
  riverpod 2.6.1 (3.4.3 available)
  rxdart 0.27.7 (0.28.0 available)
  sanitize_html 2.1.0 (2.2.0 available)
  sensors_plus 5.0.1 (7.1.1 available)
  sensors_plus_platform_interface 1.2.0 (2.0.2 available)
! share_plus 12.0.2 (overridden) (13.3.1 available)
  share_plus_platform_interface 6.1.0 (7.2.0 available)
  shared_preferences 2.5.5 (2.5.6 available)
  shared_preferences_android 2.4.7 (2.5.3 available)
  shared_preferences_foundation 2.5.3 (2.6.0 available)
  shared_preferences_platform_interface 2.4.1 (2.4.2 available)
  shared_preferences_web 2.4.2 (2.4.3 available)
  shelf 1.4.1 (1.4.3 available)
  shelf_web_socket 2.0.0 (3.0.0 available)
  shimmer 2.0.0 (4.0.0 available)
  sign_in_with_apple 6.1.4 (8.2.0 available)
  sign_in_with_apple_platform_interface 1.1.0 (2.0.0 available)
  sign_in_with_apple_web 2.1.1 (3.0.0 available)
  sms_autofill 2.5.0 (2.6.1 available)
  source_gen 4.2.4 (4.3.1 available)
  sqflite 2.4.0 (2.4.5 available)
  sqflite_android 2.4.0 (2.4.5 available)
  sqflite_common 2.5.4+5 (2.5.14 available)
  sqflite_darwin 2.4.1-1 (2.4.4+1 available)
  sqflite_platform_interface 2.4.0 (2.4.3 available)
! sqlite3 2.9.4 (overridden) (3.7.1 available)
  sqlite3_flutter_libs 0.5.42 (0.6.0+eol available)
  stack_trace 1.12.1 (1.12.2 available)
  stream_transform 2.1.0 (2.1.2 available)
  string_scanner 1.2.0 (1.4.1 available)
  synchronized 3.3.0+3 (3.5.0 available)
  table_calendar 3.2.1 (3.3.0 available)
  term_glyph 1.2.1 (1.2.2 available)
  test_api 0.7.7 (0.7.15 available)
  timezone 0.10.1 (0.11.2 available)
  top_snackbar_flutter 3.1.0 (3.4.0 available)
  typed_data 1.3.2 (1.4.0 available)
  universal_io 2.2.2 (2.3.1 available)
  url_launcher 6.3.2 (6.3.3 available)
  url_launcher_android 6.3.12 (6.3.33 available)
  url_launcher_ios 6.3.1 (6.4.2 available)
  url_launcher_linux 3.2.0 (3.2.3 available)
  url_launcher_macos 3.2.1 (3.2.6 available)
  url_launcher_web 2.3.3 (2.4.3 available)
  url_launcher_windows 3.1.2 (3.1.6 available)
  vector_graphics 1.2.3 (1.2.4 available)
  vector_graphics_codec 1.1.11+1 (1.1.13 available)
  vector_graphics_compiler 1.3.0 (1.3.2 available)
  vector_math 2.2.0 (2.4.3 available)
  vm_service 14.2.5 (15.4.0 available)
  web 1.1.1 (1.1.2 available)
  web_socket 0.1.6 (1.0.1 available)
  web_socket_channel 3.0.1 (3.0.3 available)
  webdriver 3.1.0 (3.2.0 available)
  webview_flutter_android 4.12.0 (4.14.1 available)
  webview_flutter_wkwebview 3.25.1 (3.27.2 available)
  win32 5.5.5 (6.4.0 available)
  win32_registry 1.1.5 (3.0.3 available)
  xml 6.5.0 (7.1.0 available)
  yaml 3.1.3 (3.1.4 available)
Got dependencies!
242 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
W These options have been removed and were ignored: --delete-conflicting-outputs
  0s freezed on 150 inputs; integration_test/guided_tour_test.dart
  0s freezed on 150 inputs: 1 skipped; integration_test/tour_steps.g.dart
  0s freezed on 150 inputs: 150 skipped
  0s auto_route_generator on 300 inputs; integration_test/guided_tour_test.dart
  0s auto_route_generator on 300 inputs: 300 skipped
  0s auto_route_generator:auto_router_generator on 300 inputs; integration_test/guided_tour_test.dart
  0s auto_route_generator:auto_router_generator on 300 inputs: 300 skipped
E auto_route_generator on lib/presentation/pages/subscriptions/subscriptions_page.dart:
  subscriptionsGuide is not a class element
  package:manager/presentation/pages/subscriptions/subscriptions_page.dart:66:23
     ╷
  66 │ const GuideDefinition subscriptionsGuide = GuideDefinition(
     │                       ^^^^^^^^^^^^^^^^^^
     ╵
  Failed to build with build_runner/jit in 2s; wrote 0 outputs.
````

</details>
