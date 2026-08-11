import 'dart:math' as math;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:rxdart/rxdart.dart';

enum DeviceTiltDirection {
  up,
  down,
  flat,
  neutral,
}

class TiltEvent {
  final double pitch; // Angle relative to vertical tilt (-180 to 180)
  final double roll;  // Side-to-side rotation (-90 to 90)
  final DeviceTiltDirection direction;

  TiltEvent({
    required this.pitch,
    required this.roll,
    required this.direction,
  });
}

class DeviceSensorManager {
  DeviceSensorManager._();

  static final DeviceSensorManager _instance = DeviceSensorManager._();
  static DeviceSensorManager get instance => _instance;

  /// Exposes a stream of device tilt orientation changes based on accelerometer events
  Stream<TiltEvent> get tiltStream {
    return accelerometerEventStream().map((AccelerometerEvent event) {
      // Calculate pitch and roll in degrees
      // Pitch: rotation around X axis (vertical tilt)
      final double pitch = math.atan2(event.y, event.z) * 180 / math.pi;
      
      // Roll: rotation around Y axis (side-to-side tilt)
      final double roll = math.atan2(-event.x, math.sqrt(event.y * event.y + event.z * event.z)) * 180 / math.pi;

      DeviceTiltDirection direction = DeviceTiltDirection.neutral;

      // Define standard tilt thresholds (configurable if needed)
      // Pitch > 50 degrees represents device pointing downward (e.g. tilted towards ground)
      // Pitch < -20 degrees represents device pointing upward
      if (pitch > 50) {
        direction = DeviceTiltDirection.down;
      } else if (pitch < -20) {
        direction = DeviceTiltDirection.up;
      } else if (pitch.abs() < 10 && roll.abs() < 10) {
        direction = DeviceTiltDirection.flat;
      }

      return TiltEvent(
        pitch: pitch,
        roll: roll,
        direction: direction,
      );
    }).shareValue();
  }
}
