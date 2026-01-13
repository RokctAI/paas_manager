class ExpenseResponse {
  final List<Expense>? data;

  ExpenseResponse({this.data});

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) =>
      ExpenseResponse(
        data: json["data"] == null
            ? []
            : List<Expense>.from(
                json["data"]!.map((x) => Expense.fromJson(x))),
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
