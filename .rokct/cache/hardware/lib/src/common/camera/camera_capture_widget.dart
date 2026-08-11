import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'camera_capture_service.dart';

/// A live camera preview with a shutter button, mirroring the thin-wrapper
/// style of `MobileScannerWidget`. Emits the raw captured bytes through
/// [onCaptured]; stamping is left to the caller / `CameraStampService`.
///
/// If no [service] is supplied the widget creates and owns a
/// [DeviceCameraCaptureService], initializing it on mount and disposing it on
/// unmount. When a [service] is supplied the caller owns its lifecycle.
class CameraCaptureWidget extends StatefulWidget {
  /// Called with the encoded bytes of each captured frame.
  final void Function(Uint8List photoBytes) onCaptured;

  /// Optional externally-owned capture service. When null the widget manages
  /// its own.
  final DeviceCameraCaptureService? service;

  /// Optional overlay drawn on top of the preview (framing guides, etc.).
  final Widget? overlay;

  /// Builder for the shutter control. Receives a callback that performs the
  /// capture. Defaults to a centered [FloatingActionButton].
  final Widget Function(BuildContext context, VoidCallback onCapture)?
      shutterBuilder;

  const CameraCaptureWidget({
    super.key,
    required this.onCaptured,
    this.service,
    this.overlay,
    this.shutterBuilder,
  });

  @override
  State<CameraCaptureWidget> createState() => _CameraCaptureWidgetState();
}

class _CameraCaptureWidgetState extends State<CameraCaptureWidget> {
  late final DeviceCameraCaptureService _service;
  late final bool _ownsService;
  Future<void>? _initFuture;
  bool _capturing = false;

  @override
  void initState() {
    super.initState();
    _ownsService = widget.service == null;
    _service = widget.service ?? DeviceCameraCaptureService();
    _initFuture = _service.initialize();
  }

  @override
  void dispose() {
    if (_ownsService) {
      _service.dispose();
    }
    super.dispose();
  }

  Future<void> _capture() async {
    if (_capturing || !_service.isInitialized) return;
    setState(() => _capturing = true);
    try {
      final bytes = await _service.capture();
      widget.onCaptured(bytes);
    } finally {
      if (mounted) {
        setState(() => _capturing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || _service.controller == null) {
          return Center(
            child: Text('Camera unavailable: ${snapshot.error ?? 'unknown'}'),
          );
        }

        final shutter = widget.shutterBuilder?.call(context, _capture) ??
            _defaultShutter();

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(child: CameraPreview(_service.controller!)),
            if (widget.overlay != null) Positioned.fill(child: widget.overlay!),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: shutter,
            ),
          ],
        );
      },
    );
  }

  Widget _defaultShutter() {
    return FloatingActionButton(
      onPressed: _capturing ? null : _capture,
      child: _capturing
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.camera_alt),
    );
  }
}
