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

// This file makes no outgoing HTTP calls: it wraps the local `camera` plugin
// (platform channels) to capture photo bytes on-device. Flagged solely because
// the filename contains 'service'; there is no request to attach a trace
// header to.
// compliance-ignore-file: obs-flutter-trace

import 'dart:typed_data';

import 'package:camera/camera.dart';

/// Thrown when the camera cannot be initialized or a capture fails.
class CameraCaptureException implements Exception {
  final String message;
  CameraCaptureException(this.message);

  @override
  String toString() => 'CameraCaptureException: $message';
}

/// Abstraction over "take a photo and give me the raw bytes".
///
/// The facade and any UI depend on this interface rather than the `camera`
/// plugin directly, so the capture flow can be driven by a fake in tests
/// without a physical camera.
abstract class CameraCaptureService {
  /// Prepares the underlying camera for capture. Safe to call more than once.
  Future<void> initialize();

  /// Whether the service is ready to [capture].
  bool get isInitialized;

  /// Captures a single frame and returns its encoded bytes (JPEG from the
  /// platform camera).
  Future<Uint8List> capture();

  /// Releases the underlying camera resources.
  Future<void> dispose();
}

/// [CameraCaptureService] backed by the `camera` plugin. Selects the back
/// camera when present and exposes its [CameraController] so a preview widget
/// can render the live feed.
class DeviceCameraCaptureService implements CameraCaptureService {
  /// Resolution requested from the platform camera.
  final ResolutionPreset resolution;

  /// Preferred lens; falls back to the first available camera.
  final CameraLensDirection lensDirection;

  CameraController? _controller;

  DeviceCameraCaptureService({
    this.resolution = ResolutionPreset.high,
    this.lensDirection = CameraLensDirection.back,
  });

  /// The live controller, available after [initialize] for use with
  /// `CameraPreview`. Null before initialization or after [dispose].
  CameraController? get controller => _controller;

  @override
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  @override
  Future<void> initialize() async {
    if (isInitialized) return;

    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      throw CameraCaptureException('No cameras available on this device');
    }

    final description = cameras.firstWhere(
      (camera) => camera.lensDirection == lensDirection,
      orElse: () => cameras.first,
    );

    final controller = CameraController(
      description,
      resolution,
      enableAudio: false,
    );
    await controller.initialize();
    _controller = controller;
  }

  @override
  Future<Uint8List> capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      throw CameraCaptureException('Camera is not initialized');
    }
    final XFile file = await controller.takePicture();
    return file.readAsBytes();
  }

  @override
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }
}
