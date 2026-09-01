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

enum PrinterType { bluetooth, usb, tcp, unknown }

class PrinterDevice {
  final String name;
  final String operatingSystem;
  final String? vendorId;
  final String? productId;
  final String? address;
  final PrinterType type;

  PrinterDevice({
    required this.name,
    this.address,
    this.vendorId,
    this.productId,
    this.type = PrinterType.unknown,
  }) : operatingSystem = Platform.operatingSystem;

  @override
  String toString() {
    return 'PrinterDevice(name: $name, address: $address, type: $type, os: $operatingSystem)';
  }
}
