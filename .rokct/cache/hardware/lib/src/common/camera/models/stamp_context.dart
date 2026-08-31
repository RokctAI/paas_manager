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

import 'package:geolocator/geolocator.dart';

/// Data available to a [StampContentBuilder] when composing the text lines that
/// get burned into a photo. Carries the capture [timestamp] and, when
/// available, the [position] resolved via base_sdk's `LocationService`.
class StampContext {
  /// When the photo was captured.
  final DateTime timestamp;

  /// Device position at capture time, or null when location was unavailable or
  /// not requested.
  final Position? position;

  const StampContext({required this.timestamp, this.position});
}

/// Builds the ordered text lines to burn into a captured photo. Callers supply
/// their own builder to control exactly what is stamped, so this stays a
/// generic hardware capability rather than being shaped for any one consumer.
typedef StampContentBuilder = List<String> Function(StampContext context);
