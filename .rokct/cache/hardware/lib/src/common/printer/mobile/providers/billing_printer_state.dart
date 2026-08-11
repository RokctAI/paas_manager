import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hardware_sdk/src/common/printer/mobile/models/data/printer_device.dart';

part 'billing_printer_state.freezed.dart';

enum PrinterStatus {
  initial,
  scanning,
  scanSuccess,
  scanFailure,
  connecting,
  connected,
  connectionFailure,
  disconnected,
  testPrinting,
}

@freezed
class BillingPrinterState with _$BillingPrinterState {
  const factory BillingPrinterState({
    @Default(PrinterStatus.initial) PrinterStatus status,
    @Default([]) List<PrinterDevice> devices,
    String? connectedMac,
    String? connectedName,
    String? errorMessage,
  }) = _BillingPrinterState;

  const BillingPrinterState._();
}
