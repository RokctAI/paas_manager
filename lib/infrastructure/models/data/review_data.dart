import 'image_data.dart';
import 'user_data.dart';

class ReviewData {
  ReviewData({
    int? id,
    int? reviewableId,
    String? rating,
    String? comment,
    String? img,
    String? createdAt,
    List<ImageData>? galleries,
    UserData? user,
  }) {
    _id = id;
    _reviewableId = reviewableId;
    _rating = rating;
    _comment = comment;
    _img = img;
    _createdAt = createdAt;
    _galleries = galleries;
    _user = user;
  }

  ReviewData.fromJson(dynamic json) {
    _id = json['id'];
    _reviewableId = json['reviewable_id'];
    _rating = json['rating'];
    _comment = json['comment'];
    _img = json['img'];
    _createdAt = json['created_at'];
    if (json['galleries'] != null) {
      _galleries = [];
      json['galleries'].forEach((v) {
        _galleries?.add(ImageData.fromJson(v));
      });
    }
    _user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  int? _id;
  int? _reviewableId;
  String? _rating;
  String? _comment;
  String? _img;
  String? _createdAt;
  List<ImageData>? _galleries;
  UserData? _user;

  ReviewData copyWith({
    int? id,
    int? reviewableId,
    String? rating,
    String? comment,
    String? img,
    String? createdAt,
    String? updatedAt,
    List<ImageData>? galleries,
    UserData? user,
  }) =>
      ReviewData(
        id: id ?? _id,
        reviewableId: reviewableId ?? _reviewableId,
        rating: rating ?? _rating,
        comment: comment ?? _comment,
        img: img ?? _img,
        createdAt: createdAt ?? _createdAt,
        galleries: galleries ?? _galleries,
        user: user ?? _user,
      );

  int? get id => _id;

  int? get reviewableId => _reviewableId;

  String? get rating => _rating;

  String? get comment => _comment;

  String? get img => _img;

  String? get createdAt => _createdAt;

  List<ImageData>? get galleries => _galleries;

  UserData? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reviewable_id'] = _reviewableId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['img'] = _img;
    map['created_at'] = _createdAt;
    if (_galleries != null) {
      map['galleries'] = _galleries?.map((v) => v.toJson()).toList();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
