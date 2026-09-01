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
