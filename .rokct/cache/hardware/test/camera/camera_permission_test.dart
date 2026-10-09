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

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hardware_sdk/hardware_sdk.dart';

void main() {
  late int requests;
  late int settingsOpened;
  late CameraPermissionResult answer;

  setUp(() {
    requests = 0;
    settingsOpened = 0;
    answer = CameraPermissionResult.denied;
    CameraPermission.requestOverride = () async {
      requests++;
      return answer;
    };
    CameraPermission.openSettingsOverride = () async {
      settingsOpened++;
      return true;
    };
  });

  tearDown(() {
    CameraPermission.requestOverride = null;
    CameraPermission.openSettingsOverride = null;
  });

  test('nothing is asked until the camera is first used', () {
    DeviceCameraCaptureService();
    expect(requests, 0);
  });

  test('a refusal throws CameraPermissionDeniedException', () async {
    final service = DeviceCameraCaptureService();
    await expectLater(
      service.initialize(),
      throwsA(isA<CameraPermissionDeniedException>()
          .having((e) => e.permanentlyDenied, 'permanentlyDenied', isFalse)),
    );
    expect(requests, 1);
    expect(service.isInitialized, isFalse);
  });

  test('a permanent refusal says so', () async {
    answer = CameraPermissionResult.permanentlyDenied;
    await expectLater(
      DeviceCameraCaptureService().initialize(),
      throwsA(isA<CameraPermissionDeniedException>()
          .having((e) => e.permanentlyDenied, 'permanentlyDenied', isTrue)),
    );
  });

  testWidgets('the widget explains a refusal, retries and links to settings',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: CameraCaptureWidget(onCaptured: (_) {})),
    ));
    await tester.pumpAndSettle();

    expect(requests, 1);
    expect(find.text('Camera access is needed to take a photo.'),
        findsOneWidget);

    await tester.tap(find.byKey(const Key('camera-permission-open-settings')));
    await tester.pumpAndSettle();
    expect(settingsOpened, 1);

    answer = CameraPermissionResult.permanentlyDenied;
    await tester.tap(find.byKey(const Key('camera-permission-retry')));
    await tester.pumpAndSettle();
    expect(requests, 2);
    expect(find.byKey(const Key('camera-permission-retry')), findsNothing);
    expect(find.byKey(const Key('camera-permission-open-settings')),
        findsOneWidget);
  });
}
