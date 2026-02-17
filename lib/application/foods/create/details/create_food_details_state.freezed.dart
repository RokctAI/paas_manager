// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateFoodDetailsState {

 String get title; String get description; Map<String, String> get titleTranslations; Map<String, String> get descriptionTranslations; String get tax; String get minQty; String get maxQty; String get qrcode; String get interval; String get uid; String get productType; bool get active; bool get isCreating; List<String> get images; List<Galleries> get listOfUrls; ProductData? get createdProduct;
/// Create a copy of CreateFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFoodDetailsStateCopyWith<CreateFoodDetailsState> get copyWith => _$CreateFoodDetailsStateCopyWithImpl<CreateFoodDetailsState>(this as CreateFoodDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFoodDetailsState&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.titleTranslations, titleTranslations)&&const DeepCollectionEquality().equals(other.descriptionTranslations, descriptionTranslations)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.maxQty, maxQty) || other.maxQty == maxQty)&&(identical(other.qrcode, qrcode) || other.qrcode == qrcode)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.active, active) || other.active == active)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.listOfUrls, listOfUrls)&&(identical(other.createdProduct, createdProduct) || other.createdProduct == createdProduct));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(titleTranslations),const DeepCollectionEquality().hash(descriptionTranslations),tax,minQty,maxQty,qrcode,interval,uid,productType,active,isCreating,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(listOfUrls),createdProduct);

@override
String toString() {
  return 'CreateFoodDetailsState(title: $title, description: $description, titleTranslations: $titleTranslations, descriptionTranslations: $descriptionTranslations, tax: $tax, minQty: $minQty, maxQty: $maxQty, qrcode: $qrcode, interval: $interval, uid: $uid, productType: $productType, active: $active, isCreating: $isCreating, images: $images, listOfUrls: $listOfUrls, createdProduct: $createdProduct)';
}


}

/// @nodoc
abstract mixin class $CreateFoodDetailsStateCopyWith<$Res>  {
  factory $CreateFoodDetailsStateCopyWith(CreateFoodDetailsState value, $Res Function(CreateFoodDetailsState) _then) = _$CreateFoodDetailsStateCopyWithImpl;
@useResult
$Res call({
 String title, String description, Map<String, String> titleTranslations, Map<String, String> descriptionTranslations, String tax, String minQty, String maxQty, String qrcode, String interval, String uid, String productType, bool active, bool isCreating, List<String> images, List<Galleries> listOfUrls, ProductData? createdProduct
});




}
/// @nodoc
class _$CreateFoodDetailsStateCopyWithImpl<$Res>
    implements $CreateFoodDetailsStateCopyWith<$Res> {
  _$CreateFoodDetailsStateCopyWithImpl(this._self, this._then);

  final CreateFoodDetailsState _self;
  final $Res Function(CreateFoodDetailsState) _then;

/// Create a copy of CreateFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? titleTranslations = null,Object? descriptionTranslations = null,Object? tax = null,Object? minQty = null,Object? maxQty = null,Object? qrcode = null,Object? interval = null,Object? uid = null,Object? productType = null,Object? active = null,Object? isCreating = null,Object? images = null,Object? listOfUrls = null,Object? createdProduct = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,titleTranslations: null == titleTranslations ? _self.titleTranslations : titleTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,descriptionTranslations: null == descriptionTranslations ? _self.descriptionTranslations : descriptionTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as String,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as String,maxQty: null == maxQty ? _self.maxQty : maxQty // ignore: cast_nullable_to_non_nullable
as String,qrcode: null == qrcode ? _self.qrcode : qrcode // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,listOfUrls: null == listOfUrls ? _self.listOfUrls : listOfUrls // ignore: cast_nullable_to_non_nullable
as List<Galleries>,createdProduct: freezed == createdProduct ? _self.createdProduct : createdProduct // ignore: cast_nullable_to_non_nullable
as ProductData?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateFoodDetailsState].
extension CreateFoodDetailsStatePatterns on CreateFoodDetailsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFoodDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFoodDetailsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFoodDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _CreateFoodDetailsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFoodDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFoodDetailsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  Map<String, String> titleTranslations,  Map<String, String> descriptionTranslations,  String tax,  String minQty,  String maxQty,  String qrcode,  String interval,  String uid,  String productType,  bool active,  bool isCreating,  List<String> images,  List<Galleries> listOfUrls,  ProductData? createdProduct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFoodDetailsState() when $default != null:
return $default(_that.title,_that.description,_that.titleTranslations,_that.descriptionTranslations,_that.tax,_that.minQty,_that.maxQty,_that.qrcode,_that.interval,_that.uid,_that.productType,_that.active,_that.isCreating,_that.images,_that.listOfUrls,_that.createdProduct);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  Map<String, String> titleTranslations,  Map<String, String> descriptionTranslations,  String tax,  String minQty,  String maxQty,  String qrcode,  String interval,  String uid,  String productType,  bool active,  bool isCreating,  List<String> images,  List<Galleries> listOfUrls,  ProductData? createdProduct)  $default,) {final _that = this;
switch (_that) {
case _CreateFoodDetailsState():
return $default(_that.title,_that.description,_that.titleTranslations,_that.descriptionTranslations,_that.tax,_that.minQty,_that.maxQty,_that.qrcode,_that.interval,_that.uid,_that.productType,_that.active,_that.isCreating,_that.images,_that.listOfUrls,_that.createdProduct);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  Map<String, String> titleTranslations,  Map<String, String> descriptionTranslations,  String tax,  String minQty,  String maxQty,  String qrcode,  String interval,  String uid,  String productType,  bool active,  bool isCreating,  List<String> images,  List<Galleries> listOfUrls,  ProductData? createdProduct)?  $default,) {final _that = this;
switch (_that) {
case _CreateFoodDetailsState() when $default != null:
return $default(_that.title,_that.description,_that.titleTranslations,_that.descriptionTranslations,_that.tax,_that.minQty,_that.maxQty,_that.qrcode,_that.interval,_that.uid,_that.productType,_that.active,_that.isCreating,_that.images,_that.listOfUrls,_that.createdProduct);case _:
  return null;

}
}

}

/// @nodoc


class _CreateFoodDetailsState extends CreateFoodDetailsState {
  const _CreateFoodDetailsState({this.title = '', this.description = '', final  Map<String, String> titleTranslations = const {}, final  Map<String, String> descriptionTranslations = const {}, this.tax = '', this.minQty = '', this.maxQty = '', this.qrcode = '', this.interval = '', this.uid = '', this.productType = 'single', this.active = true, this.isCreating = false, final  List<String> images = const [], final  List<Galleries> listOfUrls = const [], this.createdProduct}): _titleTranslations = titleTranslations,_descriptionTranslations = descriptionTranslations,_images = images,_listOfUrls = listOfUrls,super._();
  

@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
 final  Map<String, String> _titleTranslations;
@override@JsonKey() Map<String, String> get titleTranslations {
  if (_titleTranslations is EqualUnmodifiableMapView) return _titleTranslations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_titleTranslations);
}

 final  Map<String, String> _descriptionTranslations;
@override@JsonKey() Map<String, String> get descriptionTranslations {
  if (_descriptionTranslations is EqualUnmodifiableMapView) return _descriptionTranslations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_descriptionTranslations);
}

@override@JsonKey() final  String tax;
@override@JsonKey() final  String minQty;
@override@JsonKey() final  String maxQty;
@override@JsonKey() final  String qrcode;
@override@JsonKey() final  String interval;
@override@JsonKey() final  String uid;
@override@JsonKey() final  String productType;
@override@JsonKey() final  bool active;
@override@JsonKey() final  bool isCreating;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<Galleries> _listOfUrls;
@override@JsonKey() List<Galleries> get listOfUrls {
  if (_listOfUrls is EqualUnmodifiableListView) return _listOfUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listOfUrls);
}

@override final  ProductData? createdProduct;

/// Create a copy of CreateFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFoodDetailsStateCopyWith<_CreateFoodDetailsState> get copyWith => __$CreateFoodDetailsStateCopyWithImpl<_CreateFoodDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFoodDetailsState&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._titleTranslations, _titleTranslations)&&const DeepCollectionEquality().equals(other._descriptionTranslations, _descriptionTranslations)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.maxQty, maxQty) || other.maxQty == maxQty)&&(identical(other.qrcode, qrcode) || other.qrcode == qrcode)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.productType, productType) || other.productType == productType)&&(identical(other.active, active) || other.active == active)&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._listOfUrls, _listOfUrls)&&(identical(other.createdProduct, createdProduct) || other.createdProduct == createdProduct));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(_titleTranslations),const DeepCollectionEquality().hash(_descriptionTranslations),tax,minQty,maxQty,qrcode,interval,uid,productType,active,isCreating,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_listOfUrls),createdProduct);

@override
String toString() {
  return 'CreateFoodDetailsState(title: $title, description: $description, titleTranslations: $titleTranslations, descriptionTranslations: $descriptionTranslations, tax: $tax, minQty: $minQty, maxQty: $maxQty, qrcode: $qrcode, interval: $interval, uid: $uid, productType: $productType, active: $active, isCreating: $isCreating, images: $images, listOfUrls: $listOfUrls, createdProduct: $createdProduct)';
}


}

/// @nodoc
abstract mixin class _$CreateFoodDetailsStateCopyWith<$Res> implements $CreateFoodDetailsStateCopyWith<$Res> {
  factory _$CreateFoodDetailsStateCopyWith(_CreateFoodDetailsState value, $Res Function(_CreateFoodDetailsState) _then) = __$CreateFoodDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, Map<String, String> titleTranslations, Map<String, String> descriptionTranslations, String tax, String minQty, String maxQty, String qrcode, String interval, String uid, String productType, bool active, bool isCreating, List<String> images, List<Galleries> listOfUrls, ProductData? createdProduct
});




}
/// @nodoc
class __$CreateFoodDetailsStateCopyWithImpl<$Res>
    implements _$CreateFoodDetailsStateCopyWith<$Res> {
  __$CreateFoodDetailsStateCopyWithImpl(this._self, this._then);

  final _CreateFoodDetailsState _self;
  final $Res Function(_CreateFoodDetailsState) _then;

/// Create a copy of CreateFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? titleTranslations = null,Object? descriptionTranslations = null,Object? tax = null,Object? minQty = null,Object? maxQty = null,Object? qrcode = null,Object? interval = null,Object? uid = null,Object? productType = null,Object? active = null,Object? isCreating = null,Object? images = null,Object? listOfUrls = null,Object? createdProduct = freezed,}) {
  return _then(_CreateFoodDetailsState(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,titleTranslations: null == titleTranslations ? _self._titleTranslations : titleTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,descriptionTranslations: null == descriptionTranslations ? _self._descriptionTranslations : descriptionTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as String,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as String,maxQty: null == maxQty ? _self.maxQty : maxQty // ignore: cast_nullable_to_non_nullable
as String,qrcode: null == qrcode ? _self.qrcode : qrcode // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,productType: null == productType ? _self.productType : productType // ignore: cast_nullable_to_non_nullable
as String,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,listOfUrls: null == listOfUrls ? _self._listOfUrls : listOfUrls // ignore: cast_nullable_to_non_nullable
as List<Galleries>,createdProduct: freezed == createdProduct ? _self.createdProduct : createdProduct // ignore: cast_nullable_to_non_nullable
as ProductData?,
  ));
}


}

// dart format on
