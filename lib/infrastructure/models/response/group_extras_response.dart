import '../data/group.dart';

class GroupExtrasResponse {
  GroupExtrasResponse({Group? data}) {
    _data = data;
  }

  GroupExtrasResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Group.fromJson(json['data']) : null;
  }

  Group? _data;

  GroupExtrasResponse copyWith({Group? data}) =>
      GroupExtrasResponse(data: data ?? _data);

  Group? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
