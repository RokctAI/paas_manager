library hardware_sdk;

// Common: safe for any consumer of hardware_sdk, including a hypothetical
// future customer-facing app. Desktop/POS-only hardware lives in the
// separate hardware_sdk_pos.dart barrel instead - see decision_log.md's
// "common/ folder convention" entry.
export 'src/common/sensors/device_sensor_manager.dart';
export 'src/common/scanner/base_scanner.dart';
export 'src/common/scanner/mobile/mobile_scanner_widget.dart';

// Camera capture + stamp capability (photo capture, timestamp/location burn-in)
export 'src/common/camera/camera_capture_service.dart';
export 'src/common/camera/camera_capture_widget.dart';
export 'src/common/camera/camera_stamp_service.dart';
export 'src/common/camera/image_stamper.dart';
export 'src/common/camera/models/stamp_options.dart';
export 'src/common/camera/models/stamp_context.dart';
export 'src/common/camera/models/stamped_photo.dart';

export 'src/common/di/hardware_di.dart';
