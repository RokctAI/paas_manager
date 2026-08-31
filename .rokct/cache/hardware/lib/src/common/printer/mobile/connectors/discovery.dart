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
