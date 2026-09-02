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
