library hardware_sdk_desktop;

// POS/desktop-only hardware — not exported from the main hardware_sdk.dart
// barrel, so a consumer that only needs common/ (camera, sensors, mobile
// printer/scanner) never has these symbols visible. Manager can import this
// too if it ever needs desktop hardware access — this isn't a permission
// wall, just keeps the common barrel minimal. See decision_log.md's
// "common/ folder convention" entry.
export 'src/pos/printer/desktop/printer.dart';
export 'src/pos/printer/desktop/printer_manager.dart';
export 'src/pos/printer/desktop/models/printer_device.dart';
export 'src/pos/printer/desktop/printer_help.dart';
export 'src/pos/scanner/desktop/desktop_scanner_listener.dart';
