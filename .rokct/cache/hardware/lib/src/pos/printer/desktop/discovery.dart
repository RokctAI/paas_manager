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
