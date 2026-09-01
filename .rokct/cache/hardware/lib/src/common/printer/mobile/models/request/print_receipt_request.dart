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

class PrintReceiptRequest {
  final String shopName;
  final String address1;
  final String address2;
  final String phone;
  final List<Map<String, dynamic>> items;
  final double total;
  final String footer;

  PrintReceiptRequest({
    required this.shopName,
    required this.address1,
    required this.address2,
    required this.phone,
    required this.items,
    required this.total,
    required this.footer,
  });
}
