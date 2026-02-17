class NonExistPayment {
  int? id;
  String? tag;
  int? input;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;

  NonExistPayment({
    this.id,
    this.tag,
    this.input,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  NonExistPayment copyWith({
    int? id,
    String? tag,
    int? input,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      NonExistPayment(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        input: input ?? this.input,
        active: active ?? this.active,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory NonExistPayment.fromJson(Map<String, dynamic> json) =>
      NonExistPayment(
        id: json["id"],
        tag: json["tag"],
        input: json["input"],
        active: json["active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"])?.toLocal(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"])?.toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
        "input": input,
        "active": active,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
