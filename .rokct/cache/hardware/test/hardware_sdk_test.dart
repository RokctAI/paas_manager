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
