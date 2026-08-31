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

import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../printer_manager.dart';
import '../models/request/print_receipt_request.dart';
import 'billing_printer_state.dart';

class BillingPrinterNotifier extends StateNotifier<BillingPrinterState> {
  final PrinterManager _printerManager = PrinterManager();

  BillingPrinterNotifier() : super(const BillingPrinterState()) {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final mac = prefs.getString('printer_mac');
    final name = prefs.getString('printer_name');
    state = state.copyWith(
      status: PrinterStatus.initial,
      connectedMac: mac,
      connectedName: name,
    );
  }

  Future<void> scanPrinters() async {
    state = state.copyWith(status: PrinterStatus.scanning, errorMessage: null);
    try {
      if (await _printerManager.checkPermission()) {
        final devices = await _printerManager.discoverPrinters();
        state = state.copyWith(
          status: PrinterStatus.scanSuccess,
          devices: devices,
        );
      } else {
        state = state.copyWith(
          status: PrinterStatus.scanFailure,
          errorMessage: 'Bluetooth permission denied',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: PrinterStatus.scanFailure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> connect(String mac, String name) async {
    state = state.copyWith(
      status: PrinterStatus.connecting,
      errorMessage: null,
    );
    final response = await _printerManager.connect(mac);
    if (response.isSuccess) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('printer_mac', mac);
      await prefs.setString('printer_name', name);
      state = state.copyWith(
        status: PrinterStatus.connected,
        connectedMac: mac,
        connectedName: name,
      );
    } else {
      state = state.copyWith(
        status: PrinterStatus.connectionFailure,
        errorMessage: response.message,
      );
    }
  }

  Future<void> disconnect() async {
    final response = await _printerManager.disconnect();
    if (response.isSuccess) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('printer_mac');
      await prefs.remove('printer_name');
      state = state.copyWith(
        status: PrinterStatus.disconnected,
        connectedMac: null,
        connectedName: null,
      );
    }
  }

  Future<void> testPrint(String shopName) async {
    if (!_printerManager.isConnected) {
      state = state.copyWith(
        status: PrinterStatus.connectionFailure,
        errorMessage: 'Printer not connected',
      );
      return;
    }
    state = state.copyWith(status: PrinterStatus.testPrinting);
    await _printerManager.printText(
      "Test Print\n\n$shopName\n\n----------------\n\n",
    );
    state = state.copyWith(status: PrinterStatus.connected);
  }

  Future<void> printReceipt({
    required String shopName,
    required String address1,
    required String address2,
    required String phone,
    required List<Map<String, dynamic>> items,
    required double total,
    required String footer,
  }) async {
    if (!_printerManager.isConnected) return;

    await _printerManager.printReceipt(
      PrintReceiptRequest(
        shopName: shopName,
        address1: address1,
        address2: address2,
        phone: phone,
        items: items,
        total: total,
        footer: footer,
      ),
    );
  }
}

final billingPrinterProvider =
    StateNotifierProvider<BillingPrinterNotifier, BillingPrinterState>((ref) {
  return BillingPrinterNotifier();
});
