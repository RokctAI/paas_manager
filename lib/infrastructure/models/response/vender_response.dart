class Vender {
  final int? id;
  final String? name;

  Vender({
    this.id,
    this.name,
  });

  factory Vender.fromJson(Map<String, dynamic> json) => Vender(
        id: json["id"],
        name: json["name"],
      );
}
