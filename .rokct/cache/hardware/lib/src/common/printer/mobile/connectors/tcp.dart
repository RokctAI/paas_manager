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
import 'package:flutter/foundation.dart';
import 'package:hardware_sdk/src/common/printer/mobile/models/data/printer_device.dart';

class TcpConnector {
  static final TcpConnector _instance = TcpConnector._internal();
  factory TcpConnector() => _instance;
  TcpConnector._internal();

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Socket? _socket;

  Future<List<PrinterDevice>> discover() async {
    final List<PrinterDevice> devices = [];
    try {
      final interfaces = await NetworkInterface.list(
        includeLinkLocal: false,
        type: InternetAddressType.IPv4,
      );

      final List<String> subnets = [];
      for (final interface in interfaces) {
        for (final address in interface.addresses) {
          final ip = address.address;
          final parts = ip.split('.');
          if (parts.length == 4) {
            // Ignore localhost
            if (parts[0] == '127') continue;
            final subnet = '${parts[0]}.${parts[1]}.${parts[2]}';
            if (!subnets.contains(subnet)) {
              subnets.add(subnet);
            }
          }
        }
      }

      final List<Future<void>> scans = [];
      for (final subnet in subnets) {
        for (int i = 1; i < 255; i++) {
          final ip = '$subnet.$i';
          scans.add(() async {
            try {
              final socket = await Socket.connect(
                ip,
                9100,
                timeout: const Duration(milliseconds: 400),
              );
              socket.destroy();
              devices.add(
                PrinterDevice(
                  name: 'Network Printer ($ip)',
                  address: ip,
                  type: PrinterType.tcp,
                ),
              );
            } catch (_) {
              // Port is closed or host is unreachable
            }
          }());
        }
      }

      await Future.wait(scans);
    } catch (e) {
      debugPrint('==> TCP discovery failure: $e');
    }
    return devices;
  }

  Future<bool> connect(String ipAddress, {int port = 9100}) async {
    try {
      _socket = await Socket.connect(
        ipAddress,
        port,
        timeout: const Duration(seconds: 5),
      );
      _isConnected = true;
      return true;
    } catch (e) {
      debugPrint('==> TCP connection failure: $e');
      _isConnected = false;
      _socket?.destroy();
      _socket = null;
      return false;
    }
  }

  Future<void> disconnect() async {
    if (_socket != null) {
      try {
        await _socket!.flush();
        await _socket!.close();
      } catch (e) {
        debugPrint('==> TCP disconnect failure: $e');
      } finally {
        _socket!.destroy();
        _socket = null;
        _isConnected = false;
      }
    } else {
      _isConnected = false;
    }
  }

  Future<void> sendBytes(List<int> bytes) async {
    if (!_isConnected || _socket == null) return;
    try {
      _socket!.add(bytes);
      await _socket!.flush();
    } catch (e) {
      debugPrint('==> TCP send failure: $e');
      _isConnected = false;
      _socket?.destroy();
      _socket = null;
    }
  }
}
