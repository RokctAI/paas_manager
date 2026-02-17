import '../data/group.dart';

class SingleExtrasGroupResponse {
  SingleExtrasGroupResponse({Group? data}) {
    _data = data;
  }

  SingleExtrasGroupResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Group.fromJson(json['data']) : null;
  }

  Group? _data;

  SingleExtrasGroupResponse copyWith({Group? data}) =>
      SingleExtrasGroupResponse(data: data ?? _data);

  Group? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
