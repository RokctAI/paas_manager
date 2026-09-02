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

import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hardware_sdk/src/common/printer/mobile/models/data/printer_device.dart';

class BluetoothConnector {
  static final BluetoothConnector _instance = BluetoothConnector._internal();
  factory BluetoothConnector() => _instance;
  BluetoothConnector._internal();

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  Future<List<PrinterDevice>> getBondedDevices() async {
    try {
      final List<BluetoothInfo> list =
          await PrintBluetoothThermal.pairedBluetooths;
      return list
          .map(
            (e) => PrinterDevice(
              name: e.name,
              address: e.macAdress,
              type: PrinterType.bluetooth,
            ),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> connect(String macAddress) async {
    try {
      final bool result = await PrintBluetoothThermal.connect(
        macPrinterAddress: macAddress,
      );
      _isConnected = result;
      return result;
    } catch (e) {
      _isConnected = false;
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      final bool result = await PrintBluetoothThermal.disconnect;
      _isConnected = !result;
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendBytes(List<int> bytes) async {
    if (!_isConnected) return;
    final bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      await PrintBluetoothThermal.writeBytes(bytes);
    }
  }
}
