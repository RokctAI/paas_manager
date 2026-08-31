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
