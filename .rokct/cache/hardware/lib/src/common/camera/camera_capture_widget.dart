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

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import 'camera_capture_service.dart';
import 'camera_permission.dart';

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

  /// Optional replacement for the built-in "camera access is off" notice,
  /// shown when the user refused the camera permission. Receives whether
  /// the refusal is permanent, a callback that asks again, and one that
  /// opens the app's OS settings page.
  final Widget Function(
    BuildContext context,
    bool permanentlyDenied,
    VoidCallback onRetry,
    VoidCallback onOpenSettings,
  )? permissionDeniedBuilder;

  const CameraCaptureWidget({
    super.key,
    required this.onCaptured,
    this.service,
    this.overlay,
    this.shutterBuilder,
    this.permissionDeniedBuilder,
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

  /// Asks again (the permission prompt runs inside initialize()).
  void _retry() {
    // The FutureBuilder only subscribes on the next frame; mark the
    // future handled now so a refusal is not reported as unhandled first.
    final Future<void> retry = _service.initialize()..ignore();
    setState(() {
      _initFuture = retry;
    });
  }

  void _openSettings() {
    CameraPermission.openSettings();
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
        final error = snapshot.error;
        if (error is CameraPermissionDeniedException) {
          return widget.permissionDeniedBuilder?.call(
                context,
                error.permanentlyDenied,
                _retry,
                _openSettings,
              ) ??
              _PermissionDeniedNotice(
                permanentlyDenied: error.permanentlyDenied,
                onRetry: _retry,
                onOpenSettings: _openSettings,
              );
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
          : const Icon(Remix.camera_fill),
    );
  }
}

/// The built-in notice for a refused camera permission: what happened, a
/// link to the app's settings page, and (while the OS will still show the
/// prompt) a way to ask again.
class _PermissionDeniedNotice extends StatelessWidget {
  final bool permanentlyDenied;
  final VoidCallback onRetry;
  final VoidCallback onOpenSettings;

  const _PermissionDeniedNotice({
    required this.permanentlyDenied,
    required this.onRetry,
    required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Remix.camera_off_line, size: 40),
            const SizedBox(height: 12),
            Text(
              permanentlyDenied
                  ? 'Camera access is turned off. Allow it in Settings to '
                      'take a photo.'
                  : 'Camera access is needed to take a photo.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              children: [
                if (!permanentlyDenied)
                  OutlinedButton(
                    key: const Key('camera-permission-retry'),
                    onPressed: onRetry,
                    child: const Text('Try again'),
                  ),
                FilledButton(
                  key: const Key('camera-permission-open-settings'),
                  onPressed: onOpenSettings,
                  child: const Text('Open settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
