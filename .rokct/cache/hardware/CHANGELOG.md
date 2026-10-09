## 1.1.2

* fix(deps): swap `flutter_pos_printer_platform_image_3` for
  `flutter_pos_printer_platform_image_3_sdt` (`>=1.2.12 <1.2.13`). The old
  plugin depends on `image_v3` -> `archive ^3`, which cannot co-resolve with
  comms_sdk's `live_activities` -> `image ^4.5.4` -> `archive ^4`, so any host
  composing both SDKs (paas_manager) failed `flutter pub get`. The fork
  registers the same native MethodChannel/EventChannel names and method
  names used by `lib/src/pos/printer`, so no Dart changes are needed.
* pubspec `version` brought in line with this changelog (was `1.0.0`).

## 1.1.1

* fix(icons): `CameraCaptureWidget` draws Remixicon (`Remix.camera_fill`,
  `Remix.camera_off_line`) instead of Material `Icons.*`. Declares
  `remixicon: ^1.4.1`.

## 1.1.0

* feat(camera): ask for the camera permission on first use.
  `DeviceCameraCaptureService.initialize()` requests it through
  permission_handler (new `CameraPermission`, Android/iOS only) before it
  opens the camera, and throws `CameraPermissionDeniedException` when the
  user refuses. `CameraCaptureWidget` shows a notice with an "Open settings"
  link (plus "Try again" while the OS will still prompt) instead of the raw
  error; `permissionDeniedBuilder` replaces that notice.
* Tests: `test/camera/camera_permission_test.dart`.

## 0.0.1

* TODO: Describe initial release.
