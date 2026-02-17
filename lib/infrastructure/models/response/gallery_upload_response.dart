import '../data/image_data.dart';

class GalleryUploadResponse {
  GalleryUploadResponse({ImageData? imageData}) {
    _imageData = imageData;
  }

  GalleryUploadResponse.fromJson(dynamic json) {
    _imageData = json['data'] != null ? ImageData.fromJson(json['data']) : null;
  }

  ImageData? _imageData;

  GalleryUploadResponse copyWith({ImageData? imageData}) =>
      GalleryUploadResponse(imageData: imageData ?? _imageData);

  ImageData? get imageData => _imageData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_imageData != null) {
      map['data'] = _imageData?.toJson();
    }
    return map;
  }
}
