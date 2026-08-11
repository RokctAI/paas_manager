import 'models/response/printer_response.dart';
import 'models/data/esc_pos.dart';
import 'models/data/printer_device.dart';
import 'models/request/print_receipt_request.dart';
import 'connectors/connectors.dart';
import 'package:intl/intl.dart';

class PrinterManager {
  static final PrinterManager _instance = PrinterManager._internal();
  factory PrinterManager() => _instance;
  PrinterManager._internal();

  final BluetoothConnector _bluetooth = BluetoothConnector();
  final TcpConnector _tcp = TcpConnector();
  final UsbConnector _usb = UsbConnector();
  final PrinterDiscovery _discovery = PrinterDiscovery();

  PrinterType _activeType = PrinterType.unknown;

  bool get isConnected {
    switch (_activeType) {
      case PrinterType.bluetooth:
        return _bluetooth.isConnected;
      case PrinterType.tcp:
        return _tcp.isConnected;
      case PrinterType.usb:
        return _usb.isConnected;
      default:
        return false;
    }
  }

  Future<bool> checkPermission() => _bluetooth.checkPermission();

  Future<List<PrinterDevice>> discoverPrinters() => _discovery.discoverAll();

  Future<PrinterResponse> connect(String address) async {
    bool success = false;
    String error = 'Failed to connect to printer';

    if (address.startsWith('usb://')) {
      final String cleanAddress = address.replaceFirst('usb://', '');
      final List<String> parts = cleanAddress.split('_');
      if (parts.length == 2) {
        success = await _usb.connect(parts[0], parts[1]);
        if (success) {
          _activeType = PrinterType.usb;
        } else {
          error = 'Failed to connect to USB printer';
        }
      } else {
        error = 'Invalid USB printer address format';
      }
    } else if (address.contains('.')) {
      success = await _tcp.connect(address);
      if (success) {
        _activeType = PrinterType.tcp;
      } else {
        error = 'Failed to connect to Network printer';
      }
    } else {
      success = await _bluetooth.connect(address);
      if (success) {
        _activeType = PrinterType.bluetooth;
      } else {
        error = 'Failed to connect to Bluetooth printer';
      }
    }

    return success ? PrinterResponse.success() : PrinterResponse.failure(error);
  }

  Future<PrinterResponse> disconnect() async {
    bool success = true;
    switch (_activeType) {
      case PrinterType.bluetooth:
        success = await _bluetooth.disconnect();
        break;
      case PrinterType.tcp:
        await _tcp.disconnect();
        break;
      case PrinterType.usb:
        await _usb.disconnect();
        break;
      default:
        break;
    }
    _activeType = PrinterType.unknown;
    return success
        ? PrinterResponse.success()
        : PrinterResponse.failure('Failed to disconnect');
  }

  Future<void> _sendBytes(List<int> bytes) async {
    switch (_activeType) {
      case PrinterType.bluetooth:
        await _bluetooth.sendBytes(bytes);
        break;
      case PrinterType.tcp:
        await _tcp.sendBytes(bytes);
        break;
      case PrinterType.usb:
        await _usb.sendBytes(bytes);
        break;
      default:
        break;
    }
  }

  Future<PrinterResponse> printText(String text) async {
    if (!isConnected) return PrinterResponse.failure('Printer not connected');
    await _sendBytes(text.codeUnits);
    return PrinterResponse.success();
  }

  Future<PrinterResponse> printReceipt(PrintReceiptRequest request) async {
    if (!isConnected) return PrinterResponse.failure('Printer not connected');

    List<int> bytes = [];
    bytes += EscPos.init;

    // Shop Name
    bytes += EscPos.alignCenter;
    bytes += EscPos.boldOn;
    bytes += EscPos.textLarge;
    bytes += _textToBytes(request.shopName);
    bytes += EscPos.lineFeed;

    // Address & Phone
    bytes += EscPos.textNormal;
    bytes += EscPos.boldOff;
    if (request.address1.isNotEmpty) {
      bytes += _textToBytes(request.address1);
      bytes += EscPos.lineFeed;
    }
    if (request.address2.isNotEmpty) {
      bytes += _textToBytes(request.address2);
      bytes += EscPos.lineFeed;
    }
    bytes += _textToBytes(request.phone);
    bytes += EscPos.lineFeed;

    // Date
    String formattedDate = DateFormat(
      'dd-MM-yyyy hh:mm a',
    ).format(DateTime.now());
    bytes += _textToBytes(formattedDate);
    bytes += EscPos.lineFeed;

    bytes += _textToBytes('--------------------------------');
    bytes += EscPos.lineFeed;

    // Header
    bytes += EscPos.alignLeft;
    bytes += _textToBytes('Item            Price   Total');
    bytes += EscPos.lineFeed;
    bytes += _textToBytes('--------------------------------');
    bytes += EscPos.lineFeed;

    // Items
    for (final item in request.items) {
      final String name = item['name'].toString();
      final String qty = item['qty'].toString();
      final String price = item['price'].toString();
      final String totalItem = item['total'].toString();

      final String prefix = '${qty}x $name';
      final int prefixLen = prefix.length;
      final int truncLen = prefixLen > 16 ? 16 : prefixLen;

      for (int i = 0; i < truncLen; i++) {
        bytes.add(prefix.codeUnitAt(i));
      }
      for (int i = truncLen; i < 16; i++) {
        bytes.add(32);
      }

      final int priceLen = price.length;
      for (int i = 0; i < priceLen; i++) {
        bytes.add(price.codeUnitAt(i));
      }
      for (int i = priceLen; i < 8; i++) {
        bytes.add(32);
      }

      bytes.addAll(totalItem.codeUnits);
      bytes.addAll(EscPos.lineFeed);
    }

    bytes += _textToBytes('--------------------------------');
    bytes += EscPos.lineFeed;

    // Total
    bytes += EscPos.alignRight;
    bytes += EscPos.boldOn;
    bytes += _textToBytes('TOTAL: ${request.total}');
    bytes += EscPos.lineFeed;
    bytes += EscPos.boldOff;
    bytes += EscPos.lineFeed;

    // Footer
    bytes += EscPos.alignCenter;
    bytes += _textToBytes(request.footer);
    bytes += EscPos.lineFeed;
    bytes += EscPos.lineFeed;
    bytes += EscPos.lineFeed;
    bytes += EscPos.lineFeed;

    await _sendBytes(bytes);
    return PrinterResponse.success();
  }

  List<int> _textToBytes(String text) {
    return List.from(text.codeUnits);
  }
}
