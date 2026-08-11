import 'dart:typed_data';

import 'package:geolocator/geolocator.dart';

/// Result of a capture-and-stamp operation.
///
/// [bytes] holds the finished, stamped image (the burned-in pixels are part of
/// the image itself, not EXIF metadata). [originalBytes] is the untouched
/// capture, retained so callers can keep or discard the pre-stamp frame.
class StampedPhoto {
  /// Encoded bytes of the stamped image.
  final Uint8List bytes;

  /// Encoded bytes of the original, un-stamped capture.
  final Uint8List originalBytes;

  /// The timestamp that was stamped onto the image.
  final DateTime timestamp;

  /// The location stamped onto the image, or null when none was available.
  final Position? position;

  /// The text lines that were burned into [bytes], in draw order.
  final List<String> stampedLines;

  const StampedPhoto({
    required this.bytes,
    required this.originalBytes,
    required this.timestamp,
    required this.stampedLines,
    this.position,
  });

  /// Whether a location was resolved and stamped.
  bool get hasLocation => position != null;
}
