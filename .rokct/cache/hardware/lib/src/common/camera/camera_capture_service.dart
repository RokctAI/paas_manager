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
