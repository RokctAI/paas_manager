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

import 'package:base_sdk/src/services/location_service.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'camera_capture_service.dart';
import 'image_stamper.dart';
import 'models/stamp_context.dart';
import 'models/stamp_options.dart';
import 'models/stamped_photo.dart';

/// Facade for the "capture a photo and burn a timestamp + location stamp into
/// it" capability.
///
/// It orchestrates three collaborators, each of which can be substituted for
/// testing:
///  * a [CameraCaptureService] for the raw capture,
///  * base_sdk's [LocationService] for the device position (ADR-005: base_sdk
///    is the shared kernel every feature SDK may import directly, so location
///    logic is reused, never duplicated here), and
///  * an [ImageStamper] that draws the text onto the actual pixels.
///
/// The stamped text is fully caller-controlled via a [StampContentBuilder], so
/// this stays a generic hardware capability rather than being shaped for any
/// specific consumer. [defaultStampContent] provides a reasonable
/// timestamp + coordinates default.
class CameraStampService {
  final CameraCaptureService _camera;
  final LocationService _locationService;
  final ImageStamper _stamper;

  CameraStampService({
    required CameraCaptureService camera,
    LocationService? locationService,
    ImageStamper stamper = const ImageStamper(),
  })  : _camera = camera,
        _locationService = locationService ?? LocationService(),
        _stamper = stamper;

  /// Prepares the underlying camera. Delegates to [CameraCaptureService].
  Future<void> initializeCamera() => _camera.initialize();

  /// Whether the camera is ready to capture.
  bool get isCameraReady => _camera.isInitialized;

  /// Captures a frame, optionally resolves the device location, then burns the
  /// composed text lines into the image pixels.
  ///
  /// [context] is required by base_sdk's [LocationService] (it surfaces
  /// permission prompts). [contentBuilder] decides what text is burned in;
  /// when omitted, [defaultStampContent] is used. Set [includeLocation] to
  /// false to skip the location lookup entirely.
  Future<StampedPhoto> captureAndStamp({
    required BuildContext context,
    StampContentBuilder? contentBuilder,
    StampOptions options = const StampOptions(),
    bool includeLocation = true,
  }) async {
    final originalBytes = await _camera.capture();
    final timestamp = DateTime.now();

    Position? position;
    if (includeLocation && context.mounted) {
      position = await _locationService.determinePosition(context);
    }

    final stampContext = StampContext(timestamp: timestamp, position: position);
    final lines = (contentBuilder ?? defaultStampContent)(stampContext);
    final stampedBytes = _stamper.stamp(originalBytes, lines, options: options);

    return StampedPhoto(
      bytes: stampedBytes,
      originalBytes: originalBytes,
      timestamp: timestamp,
      position: position,
      stampedLines: lines,
    );
  }

  /// Releases the underlying camera resources.
  Future<void> dispose() => _camera.dispose();

  /// Default TimeMark-style content: an ISO-like local timestamp plus, when a
  /// position is available, the latitude/longitude to six decimal places.
  static List<String> defaultStampContent(StampContext context) {
    final lines = <String>[
      DateFormat('yyyy-MM-dd HH:mm:ss').format(context.timestamp),
    ];
    final position = context.position;
    if (position != null) {
      lines.add(
        'Lat ${position.latitude.toStringAsFixed(6)}, '
        'Lng ${position.longitude.toStringAsFixed(6)}',
      );
    }
    return lines;
  }
}
