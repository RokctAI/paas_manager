import 'dart:convert';

class StoreInfo {
  final String storeName;
  final String branch;

  StoreInfo({
    required this.storeName,
    required this.branch,
  });

  StoreInfo copyWith({
    String? storeName,
    String? branch,
  }) {
    return StoreInfo(
      storeName: storeName ?? this.storeName,
      branch: branch ?? this.branch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeName': storeName,
      'branch': branch,
    };
  }

  factory StoreInfo.fromMap(Map<String, dynamic> map) {
    return StoreInfo(
      storeName: map['storeName'] ?? '',
      branch: map['branch'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreInfo.fromJson(String source) => StoreInfo.fromMap(json.decode(source));

  @override
  String toString() => 'StoreInfo(storeName: $storeName, branch: $branch)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoreInfo &&
        other.storeName == storeName &&
        other.branch == branch;
  }

  @override
  int get hashCode => storeName.hashCode ^ branch.hashCode;
}