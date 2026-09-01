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
