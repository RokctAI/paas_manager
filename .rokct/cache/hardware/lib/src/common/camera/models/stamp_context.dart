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
