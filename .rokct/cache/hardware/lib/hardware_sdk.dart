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
