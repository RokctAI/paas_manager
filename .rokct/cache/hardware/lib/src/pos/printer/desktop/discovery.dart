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

import 'printer_help.dart';

class PrinterDiscovered<T> {
  String name;
  T detail;

  PrinterDiscovered({required this.name, required this.detail});
}

typedef DiscoverResult<T> = Future<List<PrinterDiscovered<T>>>;

Future<List<PrinterDiscovered>> discoverPrinters({
  List<DiscoverResult Function()> modes = const [
    // discoverStarPrinter,
    UsbPrinterConnector.discoverPrinters,
    BluetoothPrinterConnector.discoverPrinters,
    TcpPrinterConnector.discoverPrinters,
  ],
}) async {
  List<PrinterDiscovered> result = [];
  await Future.wait(
    modes.map((m) async {
      result.addAll(await m());
    }),
  );
  return result;
}
