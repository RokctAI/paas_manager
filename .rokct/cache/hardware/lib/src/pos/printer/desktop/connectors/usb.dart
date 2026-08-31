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
import 'dart:io';
import 'dart:typed_data';

import '../discovery.dart';
import '../printer.dart';
import '../models/printer_device.dart';

class UsbPrinterInput extends BasePrinterInput {
  final String? name;
  final String? vendorId;
  final String? productId;

  UsbPrinterInput({this.name, this.vendorId, this.productId});
}

class UsbPrinterInfo {
  String vendorId;
  String productId;
  String manufacturer;
  String product;
  String name;
  String? model;
  bool isDefault = false;
  String deviceId;

  UsbPrinterInfo.android({
    required this.vendorId,
    required this.productId,
    required this.manufacturer,
    required this.product,
    required this.name,
    required this.deviceId,
  });

  UsbPrinterInfo.windows({
    required this.name,
    required this.model,
    required this.isDefault,
    this.vendorId = '',
    this.productId = '',
    this.manufacturer = '',
    this.product = '',
    this.deviceId = '',
  });
}

class UsbPrinterConnector implements PrinterConnector<UsbPrinterInput> {
  UsbPrinterConnector._()
      : vendorId = '',
        productId = '',
        name = '' {
    if (Platform.isAndroid) {
      flutterPrinterEventChannelUSB.receiveBroadcastStream().listen((data) {
        if (data is int) {
          _status = USBStatus.values[data];
          _statusStreamController.add(_status);
        }
      });
    }
  }

  static final UsbPrinterConnector _instance = UsbPrinterConnector._();

  static UsbPrinterConnector get instance => _instance;

  Stream<USBStatus> get _statusStream => _statusStreamController.stream;
  final StreamController<USBStatus> _statusStreamController =
      StreamController.broadcast();

  UsbPrinterConnector.android({required this.vendorId, required this.productId})
      : name = '';

  UsbPrinterConnector.windows({required this.name})
      : vendorId = '',
        productId = '';

  String vendorId;
  String productId;
  String name;
  USBStatus _status = USBStatus.none;

  USBStatus get status => _status;

  setVendor(String vendorId) => this.vendorId = vendorId;

  setProduct(String productId) => this.productId = productId;

  setName(String name) => this.name = name;

  Stream<USBStatus> get currentStatus async* {
    if (Platform.isAndroid) {
      yield* _statusStream.cast<USBStatus>();
    }
  }

  static DiscoverResult<UsbPrinterInfo> discoverPrinters() async {
    if (Platform.isAndroid) {
      final List<dynamic> results = await flutterPrinterChannel.invokeMethod(
        'getList',
      );
      return results
          .map(
            (dynamic r) => PrinterDiscovered<UsbPrinterInfo>(
              name: r['product'],
              detail: UsbPrinterInfo.android(
                vendorId: r['vendorId'],
                productId: r['productId'],
                manufacturer: r['manufacturer'],
                product: r['product'],
                name: r['name'],
                deviceId: r['deviceId'],
              ),
            ),
          )
          .toList();
    }
    if (Platform.isWindows) {
      final List<dynamic> results = await flutterPrinterChannel.invokeMethod(
        'getList',
      );
      return results
          .map(
            (dynamic result) => PrinterDiscovered<UsbPrinterInfo>(
              name: result['name'],
              detail: UsbPrinterInfo.windows(
                isDefault: result['default'],
                name: result['name'],
                model: result['model'],
              ),
            ),
          )
          .toList();
    }
    return [];
  }

  Stream<PrinterDevice> discovery() async* {
    if (Platform.isAndroid) {
      final List<dynamic> results = await flutterPrinterChannel.invokeMethod(
        'getList',
      );
      for (final device in results) {
        var r = await device;
        yield PrinterDevice(
          name: r['product'],
          vendorId: r['vendorId'],
          productId: r['productId'],
        );
      }
    } else if (Platform.isWindows) {
      final List<dynamic> results = await flutterPrinterChannel.invokeMethod(
        'getList',
      );
      for (final device in results) {
        var r = await device;
        yield PrinterDevice(name: r['name']);
      }
    }
  }

  Future<bool> _connect({UsbPrinterInput? model}) async {
    if (Platform.isAndroid) {
      Map<String, dynamic> params = {
        "vendor": int.parse(model?.vendorId ?? vendorId),
        "product": int.parse(model?.productId ?? productId),
      };
      return await flutterPrinterChannel.invokeMethod('connectPrinter', params);
    } else if (Platform.isWindows) {
      Map<String, dynamic> params = {"name": model?.name ?? name};
      return await flutterPrinterChannel.invokeMethod(
                'connectPrinter',
                params,
              ) ==
              1
          ? true
          : false;
    }
    return false;
  }

  Future<bool> _close() async {
    if (Platform.isWindows) {
      return await flutterPrinterChannel.invokeMethod('close') == 1
          ? true
          : false;
    }
    return false;
  }

  @override
  Future<bool> connect(UsbPrinterInput model) async {
    try {
      return await _connect(model: model);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> disconnect({int? delayMs}) async {
    try {
      return await _close();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> send(List<int> bytes) async {
    if (Platform.isAndroid) {
      try {
        Map<String, dynamic> params = {"bytes": bytes};
        return await flutterPrinterChannel.invokeMethod('printBytes', params);
      } catch (e) {
        return false;
      }
    } else if (Platform.isWindows) {
      try {
        Map<String, dynamic> params = {"bytes": Uint8List.fromList(bytes)};
        return await flutterPrinterChannel.invokeMethod('printBytes', params) ==
                1
            ? true
            : false;
      } catch (e) {
        await _close();
        return false;
      }
    } else {
      return false;
    }
  }
}
