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
