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

import 'package:hardware_sdk/src/common/printer/mobile/models/data/printer_device.dart';
import 'bluetooth.dart';
import 'tcp.dart';
import 'usb.dart';

class PrinterDiscovery {
  static final PrinterDiscovery _instance = PrinterDiscovery._internal();
  factory PrinterDiscovery() => _instance;
  PrinterDiscovery._internal();

  final BluetoothConnector _bluetooth = BluetoothConnector();
  final TcpConnector _tcp = TcpConnector();
  final UsbConnector _usb = UsbConnector();

  Future<List<PrinterDevice>> discoverAll() async {
    final List<PrinterDevice> devices = [];

    // Scan all transports in parallel
    final results = await Future.wait([
      _bluetooth.getBondedDevices(),
      _tcp.discover(),
      _usb.getDevices(),
    ]);

    for (var list in results) {
      devices.addAll(list);
    }

    return devices;
  }
}
