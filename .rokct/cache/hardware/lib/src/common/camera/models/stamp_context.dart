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
