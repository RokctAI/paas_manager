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
