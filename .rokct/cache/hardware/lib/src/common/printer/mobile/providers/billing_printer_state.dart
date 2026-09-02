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
abstract class BillingPrinterState with _$BillingPrinterState {
  const factory BillingPrinterState({
    @Default(PrinterStatus.initial) PrinterStatus status,
    @Default([]) List<PrinterDevice> devices,
    String? connectedMac,
    String? connectedName,
    String? errorMessage,
  }) = _BillingPrinterState;

  const BillingPrinterState._();
}
