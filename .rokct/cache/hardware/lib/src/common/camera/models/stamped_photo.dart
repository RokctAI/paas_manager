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
