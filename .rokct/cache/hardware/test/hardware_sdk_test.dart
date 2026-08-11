import 'package:flutter_test/flutter_test.dart';
import 'package:hardware_sdk/hardware_sdk.dart';

void main() {
  test('camera capability is exported from the barrel', () {
    // Smoke check: the public surface is reachable and the default stamp
    // content builder produces a timestamp line.
    final lines = CameraStampService.defaultStampContent(
      StampContext(timestamp: DateTime(2026, 7, 19, 12, 0, 0)),
    );
    expect(lines, isNotEmpty);
    expect(lines.first, '2026-07-19 12:00:00');
  });
}
