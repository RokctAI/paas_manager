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

class PrinterResponse {
  final bool isSuccess;
  final String? message;
  final dynamic data;

  PrinterResponse({required this.isSuccess, this.message, this.data});

  factory PrinterResponse.success({dynamic data}) =>
      PrinterResponse(isSuccess: true, data: data);
  factory PrinterResponse.failure(String message) =>
      PrinterResponse(isSuccess: false, message: message);
}
