// lib/water/models/shop.dart
class Shop {
  final int id;
  final String name;
  final String logoImg;
  final String title;

  Shop({
    required this.id,
    required this.name,
    required this.logoImg,
    required this.title,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      logoImg: json['logo_img'] ?? '', // Providing default empty string if null
      title: json['title'] ?? json['name'], // Using name as fallback for title
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_img': logoImg,
      'title': title,
    };
  }
}