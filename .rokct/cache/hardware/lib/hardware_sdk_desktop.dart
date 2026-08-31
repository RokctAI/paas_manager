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
