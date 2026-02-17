// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditFoodDetailsState {

 bool get isLoading; bool get active; String get title; String get interval; String get description; Map<String, String> get titleTranslations; Map<String, String> get descriptionTranslations; String get minQty; String get maxQty; String get tax; String get barcode; ProductData? get product; List<String> get images; List<Galleries> get listOfUrls; Map<String, List<String>> get mapOfDesc; LanguageData? get language;
/// Create a copy of EditFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditFoodDetailsStateCopyWith<EditFoodDetailsState> get copyWith => _$EditFoodDetailsStateCopyWithImpl<EditFoodDetailsState>(this as EditFoodDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditFoodDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.active, active) || other.active == active)&&(identical(other.title, title) || other.title == title)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.titleTranslations, titleTranslations)&&const DeepCollectionEquality().equals(other.descriptionTranslations, descriptionTranslations)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.maxQty, maxQty) || other.maxQty == maxQty)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.listOfUrls, listOfUrls)&&const DeepCollectionEquality().equals(other.mapOfDesc, mapOfDesc)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,active,title,interval,description,const DeepCollectionEquality().hash(titleTranslations),const DeepCollectionEquality().hash(descriptionTranslations),minQty,maxQty,tax,barcode,product,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(listOfUrls),const DeepCollectionEquality().hash(mapOfDesc),language);

@override
String toString() {
  return 'EditFoodDetailsState(isLoading: $isLoading, active: $active, title: $title, interval: $interval, description: $description, titleTranslations: $titleTranslations, descriptionTranslations: $descriptionTranslations, minQty: $minQty, maxQty: $maxQty, tax: $tax, barcode: $barcode, product: $product, images: $images, listOfUrls: $listOfUrls, mapOfDesc: $mapOfDesc, language: $language)';
}


}

/// @nodoc
abstract mixin class $EditFoodDetailsStateCopyWith<$Res>  {
  factory $EditFoodDetailsStateCopyWith(EditFoodDetailsState value, $Res Function(EditFoodDetailsState) _then) = _$EditFoodDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool active, String title, String interval, String description, Map<String, String> titleTranslations, Map<String, String> descriptionTranslations, String minQty, String maxQty, String tax, String barcode, ProductData? product, List<String> images, List<Galleries> listOfUrls, Map<String, List<String>> mapOfDesc, LanguageData? language
});




}
/// @nodoc
class _$EditFoodDetailsStateCopyWithImpl<$Res>
    implements $EditFoodDetailsStateCopyWith<$Res> {
  _$EditFoodDetailsStateCopyWithImpl(this._self, this._then);

  final EditFoodDetailsState _self;
  final $Res Function(EditFoodDetailsState) _then;

/// Create a copy of EditFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? active = null,Object? title = null,Object? interval = null,Object? description = null,Object? titleTranslations = null,Object? descriptionTranslations = null,Object? minQty = null,Object? maxQty = null,Object? tax = null,Object? barcode = null,Object? product = freezed,Object? images = null,Object? listOfUrls = null,Object? mapOfDesc = null,Object? language = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,titleTranslations: null == titleTranslations ? _self.titleTranslations : titleTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,descriptionTranslations: null == descriptionTranslations ? _self.descriptionTranslations : descriptionTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as String,maxQty: null == maxQty ? _self.maxQty : maxQty // ignore: cast_nullable_to_non_nullable
as String,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as String,barcode: null == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductData?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,listOfUrls: null == listOfUrls ? _self.listOfUrls : listOfUrls // ignore: cast_nullable_to_non_nullable
as List<Galleries>,mapOfDesc: null == mapOfDesc ? _self.mapOfDesc : mapOfDesc // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as LanguageData?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditFoodDetailsState].
extension EditFoodDetailsStatePatterns on EditFoodDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditFoodDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditFoodDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditFoodDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _EditFoodDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditFoodDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _EditFoodDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool active,  String title,  String interval,  String description,  Map<String, String> titleTranslations,  Map<String, String> descriptionTranslations,  String minQty,  String maxQty,  String tax,  String barcode,  ProductData? product,  List<String> images,  List<Galleries> listOfUrls,  Map<String, List<String>> mapOfDesc,  LanguageData? language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditFoodDetailsState() when $default != null:
return $default(_that.isLoading,_that.active,_that.title,_that.interval,_that.description,_that.titleTranslations,_that.descriptionTranslations,_that.minQty,_that.maxQty,_that.tax,_that.barcode,_that.product,_that.images,_that.listOfUrls,_that.mapOfDesc,_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool active,  String title,  String interval,  String description,  Map<String, String> titleTranslations,  Map<String, String> descriptionTranslations,  String minQty,  String maxQty,  String tax,  String barcode,  ProductData? product,  List<String> images,  List<Galleries> listOfUrls,  Map<String, List<String>> mapOfDesc,  LanguageData? language)  $default,) {final _that = this;
switch (_that) {
case _EditFoodDetailsState():
return $default(_that.isLoading,_that.active,_that.title,_that.interval,_that.description,_that.titleTranslations,_that.descriptionTranslations,_that.minQty,_that.maxQty,_that.tax,_that.barcode,_that.product,_that.images,_that.listOfUrls,_that.mapOfDesc,_that.language);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool active,  String title,  String interval,  String description,  Map<String, String> titleTranslations,  Map<String, String> descriptionTranslations,  String minQty,  String maxQty,  String tax,  String barcode,  ProductData? product,  List<String> images,  List<Galleries> listOfUrls,  Map<String, List<String>> mapOfDesc,  LanguageData? language)?  $default,) {final _that = this;
switch (_that) {
case _EditFoodDetailsState() when $default != null:
return $default(_that.isLoading,_that.active,_that.title,_that.interval,_that.description,_that.titleTranslations,_that.descriptionTranslations,_that.minQty,_that.maxQty,_that.tax,_that.barcode,_that.product,_that.images,_that.listOfUrls,_that.mapOfDesc,_that.language);case _:
  return null;

}
}

}

/// @nodoc


class _EditFoodDetailsState extends EditFoodDetailsState {
  const _EditFoodDetailsState({this.isLoading = false, this.active = false, this.title = '', this.interval = '', this.description = '', final  Map<String, String> titleTranslations = const {}, final  Map<String, String> descriptionTranslations = const {}, this.minQty = '', this.maxQty = '', this.tax = '', this.barcode = '', this.product, final  List<String> images = const [], final  List<Galleries> listOfUrls = const [], final  Map<String, List<String>> mapOfDesc = const {}, this.language}): _titleTranslations = titleTranslations,_descriptionTranslations = descriptionTranslations,_images = images,_listOfUrls = listOfUrls,_mapOfDesc = mapOfDesc,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool active;
@override@JsonKey() final  String title;
@override@JsonKey() final  String interval;
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

@override@JsonKey() final  String minQty;
@override@JsonKey() final  String maxQty;
@override@JsonKey() final  String tax;
@override@JsonKey() final  String barcode;
@override final  ProductData? product;
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

 final  Map<String, List<String>> _mapOfDesc;
@override@JsonKey() Map<String, List<String>> get mapOfDesc {
  if (_mapOfDesc is EqualUnmodifiableMapView) return _mapOfDesc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_mapOfDesc);
}

@override final  LanguageData? language;

/// Create a copy of EditFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditFoodDetailsStateCopyWith<_EditFoodDetailsState> get copyWith => __$EditFoodDetailsStateCopyWithImpl<_EditFoodDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditFoodDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.active, active) || other.active == active)&&(identical(other.title, title) || other.title == title)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._titleTranslations, _titleTranslations)&&const DeepCollectionEquality().equals(other._descriptionTranslations, _descriptionTranslations)&&(identical(other.minQty, minQty) || other.minQty == minQty)&&(identical(other.maxQty, maxQty) || other.maxQty == maxQty)&&(identical(other.tax, tax) || other.tax == tax)&&(identical(other.barcode, barcode) || other.barcode == barcode)&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._listOfUrls, _listOfUrls)&&const DeepCollectionEquality().equals(other._mapOfDesc, _mapOfDesc)&&(identical(other.language, language) || other.language == language));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,active,title,interval,description,const DeepCollectionEquality().hash(_titleTranslations),const DeepCollectionEquality().hash(_descriptionTranslations),minQty,maxQty,tax,barcode,product,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_listOfUrls),const DeepCollectionEquality().hash(_mapOfDesc),language);

@override
String toString() {
  return 'EditFoodDetailsState(isLoading: $isLoading, active: $active, title: $title, interval: $interval, description: $description, titleTranslations: $titleTranslations, descriptionTranslations: $descriptionTranslations, minQty: $minQty, maxQty: $maxQty, tax: $tax, barcode: $barcode, product: $product, images: $images, listOfUrls: $listOfUrls, mapOfDesc: $mapOfDesc, language: $language)';
}


}

/// @nodoc
abstract mixin class _$EditFoodDetailsStateCopyWith<$Res> implements $EditFoodDetailsStateCopyWith<$Res> {
  factory _$EditFoodDetailsStateCopyWith(_EditFoodDetailsState value, $Res Function(_EditFoodDetailsState) _then) = __$EditFoodDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool active, String title, String interval, String description, Map<String, String> titleTranslations, Map<String, String> descriptionTranslations, String minQty, String maxQty, String tax, String barcode, ProductData? product, List<String> images, List<Galleries> listOfUrls, Map<String, List<String>> mapOfDesc, LanguageData? language
});




}
/// @nodoc
class __$EditFoodDetailsStateCopyWithImpl<$Res>
    implements _$EditFoodDetailsStateCopyWith<$Res> {
  __$EditFoodDetailsStateCopyWithImpl(this._self, this._then);

  final _EditFoodDetailsState _self;
  final $Res Function(_EditFoodDetailsState) _then;

/// Create a copy of EditFoodDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? active = null,Object? title = null,Object? interval = null,Object? description = null,Object? titleTranslations = null,Object? descriptionTranslations = null,Object? minQty = null,Object? maxQty = null,Object? tax = null,Object? barcode = null,Object? product = freezed,Object? images = null,Object? listOfUrls = null,Object? mapOfDesc = null,Object? language = freezed,}) {
  return _then(_EditFoodDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,titleTranslations: null == titleTranslations ? _self._titleTranslations : titleTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,descriptionTranslations: null == descriptionTranslations ? _self._descriptionTranslations : descriptionTranslations // ignore: cast_nullable_to_non_nullable
as Map<String, String>,minQty: null == minQty ? _self.minQty : minQty // ignore: cast_nullable_to_non_nullable
as String,maxQty: null == maxQty ? _self.maxQty : maxQty // ignore: cast_nullable_to_non_nullable
as String,tax: null == tax ? _self.tax : tax // ignore: cast_nullable_to_non_nullable
as String,barcode: null == barcode ? _self.barcode : barcode // ignore: cast_nullable_to_non_nullable
as String,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductData?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,listOfUrls: null == listOfUrls ? _self._listOfUrls : listOfUrls // ignore: cast_nullable_to_non_nullable
as List<Galleries>,mapOfDesc: null == mapOfDesc ? _self._mapOfDesc : mapOfDesc // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as LanguageData?,
  ));
}


}

// dart format on
