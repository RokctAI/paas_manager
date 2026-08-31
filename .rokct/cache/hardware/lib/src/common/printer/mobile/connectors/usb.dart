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

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:hardware_sdk/src/common/printer/mobile/models/data/printer_device.dart';

class UsbConnector {
  static final UsbConnector _instance = UsbConnector._internal();
  factory UsbConnector() => _instance;
  UsbConnector._internal();

  static const MethodChannel _channel = MethodChannel(
    'com.rokctapp.printer/usb',
  );

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Future<List<PrinterDevice>> getDevices() async {
    if (!Platform.isAndroid) return [];
    try {
      final List<dynamic>? result = await _channel.invokeMethod('getDevices');
      if (result == null) return [];

      return result.map((e) {
        final Map<dynamic, dynamic> map = e as Map<dynamic, dynamic>;
        final String vId = map['vendorId']?.toString() ?? '0';
        final String pId = map['productId']?.toString() ?? '0';
        return PrinterDevice(
          name: map['name'] ?? 'USB Printer',
          vendorId: vId,
          productId: pId,
          address: 'usb://${vId}_$pId',
          type: PrinterType.usb,
        );
      }).toList();
    } catch (e) {
      debugPrint('==> USB getDevices failure: $e');
      return [];
    }
  }

  Future<bool> connect(String vendorId, String productId) async {
    if (!Platform.isAndroid) return false;
    try {
      final int? vId = int.tryParse(vendorId);
      final int? pId = int.tryParse(productId);
      if (vId == null || pId == null) return false;

      final bool? result = await _channel.invokeMethod('connect', {
        'vendorId': vId,
        'productId': pId,
      });
      _isConnected = result ?? false;
      return _isConnected;
    } catch (e) {
      debugPrint('==> USB connect failure: $e');
      _isConnected = false;
      return false;
    }
  }

  Future<void> disconnect() async {
    if (!Platform.isAndroid || !_isConnected) return;
    try {
      await _channel.invokeMethod('disconnect');
      _isConnected = false;
    } catch (e) {
      debugPrint('==> USB disconnect failure: $e');
    }
  }

  Future<void> sendBytes(List<int> bytes) async {
    if (!Platform.isAndroid || !_isConnected) return;
    try {
      await _channel.invokeMethod('sendBytes', {
        'bytes': Uint8List.fromList(bytes),
      });
    } catch (e) {
      debugPrint('==> USB sendBytes failure: $e');
    }
  }
}
