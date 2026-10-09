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

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// Outcome of asking for the camera the first time it is used.
enum CameraPermissionResult {
  /// Allowed (or the platform has no runtime camera permission).
  granted,

  /// Refused this time; the next use asks again.
  denied,

  /// Refused for good (or restricted): only the OS settings can undo it.
  permanentlyDenied,
}

/// Thrown by [DeviceCameraCaptureService.initialize] when the user refuses
/// the camera. [permanentlyDenied] tells a UI whether asking again can
/// work or only the OS settings page can.
class CameraPermissionDeniedException implements Exception {
  final bool permanentlyDenied;
  const CameraPermissionDeniedException({this.permanentlyDenied = false});

  @override
  String toString() =>
      'CameraPermissionDeniedException(permanentlyDenied: $permanentlyDenied)';
}

/// Just-in-time camera permission, through permission_handler (the
/// package this SDK already uses for Bluetooth). Asked on first use of the
/// camera, never up front.
class CameraPermission {
  CameraPermission._();

  /// Test seam: replaces the platform request. Never set in production.
  @visibleForTesting
  static Future<CameraPermissionResult> Function()? requestOverride;

  /// Test seam: replaces opening the OS app settings.
  @visibleForTesting
  static Future<bool> Function()? openSettingsOverride;

  /// Android and iOS have a runtime camera permission; the `camera`
  /// plugin handles web and desktop access itself.
  static bool get _hasRuntimePermission =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  /// Requests the camera. Never throws: a plugin failure reads as denied.
  static Future<CameraPermissionResult> request() async {
    final override = requestOverride;
    if (override != null) return override();
    if (!_hasRuntimePermission) return CameraPermissionResult.granted;
    try {
      final status = await Permission.camera.request();
      if (status.isGranted || status.isLimited) {
        return CameraPermissionResult.granted;
      }
      if (status.isPermanentlyDenied || status.isRestricted) {
        return CameraPermissionResult.permanentlyDenied;
      }
      return CameraPermissionResult.denied;
    } catch (e) {
      debugPrint('==> camera permission request failed: $e');
      return CameraPermissionResult.denied;
    }
  }

  /// Opens this app's page in the OS settings.
  static Future<bool> openSettings() async {
    final override = openSettingsOverride;
    if (override != null) return override();
    try {
      return await openAppSettings();
    } catch (e) {
      debugPrint('==> could not open app settings: $e');
      return false;
    }
  }
}
