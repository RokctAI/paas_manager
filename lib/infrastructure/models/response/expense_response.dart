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

class ExpenseResponse {
  final List<Expense>? data;

  ExpenseResponse({this.data});

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) =>
      ExpenseResponse(
        data: json["data"] == null
            ? []
            : List<Expense>.from(json["data"]!.map((x) => Expense.fromJson(x))),
      );
}

class Expense {
  final int? id;
  final String? name;
  final int? projectId;
  final double? amount;
  final String? date;
  final String? description;

  Expense({
    this.id,
    this.name,
    this.projectId,
    this.amount,
    this.date,
    this.description,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json["id"],
        name: json["name"],
        projectId: json["project_id"],
        amount: json["amount"]?.toDouble(),
        date: json["date"],
        description: json["description"],
      );
}
