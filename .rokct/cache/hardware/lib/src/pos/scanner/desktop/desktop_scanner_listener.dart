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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hardware_sdk/src/common/scanner/base_scanner.dart';

class DesktopScannerListener extends StatefulWidget {
  final Widget child;
  final Function(BarcodeScanResult result) onScan;
  final Duration bufferDuration;

  const DesktopScannerListener({
    super.key,
    required this.child,
    required this.onScan,
    this.bufferDuration = const Duration(milliseconds: 80),
  });

  @override
  State<DesktopScannerListener> createState() => _DesktopScannerListenerState();
}

class _DesktopScannerListenerState extends State<DesktopScannerListener> {
  final StringBuffer _buffer = StringBuffer();
  Timer? _timer;

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      final String? character = event.character;

      _timer?.cancel();

      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (_buffer.isNotEmpty) {
          widget.onScan(BarcodeScanResult(
            code: _buffer.toString(),
            format: 'HARDWARE_WEDGE',
          ));
          _buffer.clear();
        }
      } else if (character != null && character.isNotEmpty) {
        _buffer.write(character);

        _timer = Timer(widget.bufferDuration, () {
          _buffer.clear();
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: widget.child,
    );
  }
}
