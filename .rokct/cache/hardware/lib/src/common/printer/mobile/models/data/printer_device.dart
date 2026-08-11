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
