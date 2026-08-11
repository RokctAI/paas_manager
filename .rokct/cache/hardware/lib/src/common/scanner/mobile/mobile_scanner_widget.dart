import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../base_scanner.dart';

class MobileScannerWidget extends StatelessWidget {
  final Function(BarcodeScanResult result) onScan;
  final MobileScannerController? controller;

  const MobileScannerWidget({
    super.key,
    required this.onScan,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller ?? MobileScannerController(),
      onDetect: (capture) {
        final List<Barcode> barcodes = capture.barcodes;
        for (final barcode in barcodes) {
          final String? code = barcode.rawValue;
          if (code != null) {
            onScan(BarcodeScanResult(
              code: code,
              format: barcode.format.name,
            ));
          }
        }
      },
    );
  }
}
