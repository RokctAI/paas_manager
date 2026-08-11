// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'item_model.dart';

class BillResponse {
  final List<Bill>? data;

  BillResponse({this.data});

  factory BillResponse.fromJson(Map<String, dynamic> json) => BillResponse(
        data: json["data"] == null
            ? []
            : List<Bill>.from(json["data"]!.map((x) => Bill.fromJson(x))),
      );
}

class Bill {
  final int? id;
  final int? billId;
  final int? venderId;
  final String? billDate;
  final String? dueDate;
  final int? categoryId;
  final String? orderNumber;
  final int? status;
  final List<Item>? items;

  Bill({
    this.id,
    this.billId,
    this.venderId,
    this.billDate,
    this.dueDate,
    this.categoryId,
    this.orderNumber,
    this.status,
    this.items,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        billId: json["bill_id"],
        venderId: json["vender_id"],
        billDate: json["bill_date"],
        dueDate: json["due_date"],
        categoryId: json["category_id"],
        orderNumber: json["order_number"],
        status: json["status"],
        items: json["items"] == null
            ? []
            : List<Item>.from(
                json["items"]!.map((x) => Item.fromJson(x))),
      );
}
