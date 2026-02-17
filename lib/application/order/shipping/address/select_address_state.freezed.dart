// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_address_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectAddressState {

 bool get isSearching; bool get isSearchLoading; bool get isChoosing; List<Place> get searchedPlaces; TextEditingController? get textController; GoogleMapController? get mapController; LocationData? get location;
/// Create a copy of SelectAddressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectAddressStateCopyWith<SelectAddressState> get copyWith => _$SelectAddressStateCopyWithImpl<SelectAddressState>(this as SelectAddressState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectAddressState&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.isSearchLoading, isSearchLoading) || other.isSearchLoading == isSearchLoading)&&(identical(other.isChoosing, isChoosing) || other.isChoosing == isChoosing)&&const DeepCollectionEquality().equals(other.searchedPlaces, searchedPlaces)&&(identical(other.textController, textController) || other.textController == textController)&&(identical(other.mapController, mapController) || other.mapController == mapController)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,isSearching,isSearchLoading,isChoosing,const DeepCollectionEquality().hash(searchedPlaces),textController,mapController,location);

@override
String toString() {
  return 'SelectAddressState(isSearching: $isSearching, isSearchLoading: $isSearchLoading, isChoosing: $isChoosing, searchedPlaces: $searchedPlaces, textController: $textController, mapController: $mapController, location: $location)';
}


}

/// @nodoc
abstract mixin class $SelectAddressStateCopyWith<$Res>  {
  factory $SelectAddressStateCopyWith(SelectAddressState value, $Res Function(SelectAddressState) _then) = _$SelectAddressStateCopyWithImpl;
@useResult
$Res call({
 bool isSearching, bool isSearchLoading, bool isChoosing, List<Place> searchedPlaces, TextEditingController? textController, GoogleMapController? mapController, LocationData? location
});




}
/// @nodoc
class _$SelectAddressStateCopyWithImpl<$Res>
    implements $SelectAddressStateCopyWith<$Res> {
  _$SelectAddressStateCopyWithImpl(this._self, this._then);

  final SelectAddressState _self;
  final $Res Function(SelectAddressState) _then;

/// Create a copy of SelectAddressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isSearching = null,Object? isSearchLoading = null,Object? isChoosing = null,Object? searchedPlaces = null,Object? textController = freezed,Object? mapController = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,isSearchLoading: null == isSearchLoading ? _self.isSearchLoading : isSearchLoading // ignore: cast_nullable_to_non_nullable
as bool,isChoosing: null == isChoosing ? _self.isChoosing : isChoosing // ignore: cast_nullable_to_non_nullable
as bool,searchedPlaces: null == searchedPlaces ? _self.searchedPlaces : searchedPlaces // ignore: cast_nullable_to_non_nullable
as List<Place>,textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,mapController: freezed == mapController ? _self.mapController : mapController // ignore: cast_nullable_to_non_nullable
as GoogleMapController?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectAddressState].
extension SelectAddressStatePatterns on SelectAddressState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectAddressState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectAddressState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectAddressState value)  $default,){
final _that = this;
switch (_that) {
case _SelectAddressState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectAddressState value)?  $default,){
final _that = this;
switch (_that) {
case _SelectAddressState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isSearching,  bool isSearchLoading,  bool isChoosing,  List<Place> searchedPlaces,  TextEditingController? textController,  GoogleMapController? mapController,  LocationData? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectAddressState() when $default != null:
return $default(_that.isSearching,_that.isSearchLoading,_that.isChoosing,_that.searchedPlaces,_that.textController,_that.mapController,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isSearching,  bool isSearchLoading,  bool isChoosing,  List<Place> searchedPlaces,  TextEditingController? textController,  GoogleMapController? mapController,  LocationData? location)  $default,) {final _that = this;
switch (_that) {
case _SelectAddressState():
return $default(_that.isSearching,_that.isSearchLoading,_that.isChoosing,_that.searchedPlaces,_that.textController,_that.mapController,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isSearching,  bool isSearchLoading,  bool isChoosing,  List<Place> searchedPlaces,  TextEditingController? textController,  GoogleMapController? mapController,  LocationData? location)?  $default,) {final _that = this;
switch (_that) {
case _SelectAddressState() when $default != null:
return $default(_that.isSearching,_that.isSearchLoading,_that.isChoosing,_that.searchedPlaces,_that.textController,_that.mapController,_that.location);case _:
  return null;

}
}

}

/// @nodoc


class _SelectAddressState extends SelectAddressState {
  const _SelectAddressState({this.isSearching = false, this.isSearchLoading = false, this.isChoosing = false, final  List<Place> searchedPlaces = const [], this.textController, this.mapController, this.location}): _searchedPlaces = searchedPlaces,super._();
  

@override@JsonKey() final  bool isSearching;
@override@JsonKey() final  bool isSearchLoading;
@override@JsonKey() final  bool isChoosing;
 final  List<Place> _searchedPlaces;
@override@JsonKey() List<Place> get searchedPlaces {
  if (_searchedPlaces is EqualUnmodifiableListView) return _searchedPlaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchedPlaces);
}

@override final  TextEditingController? textController;
@override final  GoogleMapController? mapController;
@override final  LocationData? location;

/// Create a copy of SelectAddressState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectAddressStateCopyWith<_SelectAddressState> get copyWith => __$SelectAddressStateCopyWithImpl<_SelectAddressState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectAddressState&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.isSearchLoading, isSearchLoading) || other.isSearchLoading == isSearchLoading)&&(identical(other.isChoosing, isChoosing) || other.isChoosing == isChoosing)&&const DeepCollectionEquality().equals(other._searchedPlaces, _searchedPlaces)&&(identical(other.textController, textController) || other.textController == textController)&&(identical(other.mapController, mapController) || other.mapController == mapController)&&(identical(other.location, location) || other.location == location));
}


@override
int get hashCode => Object.hash(runtimeType,isSearching,isSearchLoading,isChoosing,const DeepCollectionEquality().hash(_searchedPlaces),textController,mapController,location);

@override
String toString() {
  return 'SelectAddressState(isSearching: $isSearching, isSearchLoading: $isSearchLoading, isChoosing: $isChoosing, searchedPlaces: $searchedPlaces, textController: $textController, mapController: $mapController, location: $location)';
}


}

/// @nodoc
abstract mixin class _$SelectAddressStateCopyWith<$Res> implements $SelectAddressStateCopyWith<$Res> {
  factory _$SelectAddressStateCopyWith(_SelectAddressState value, $Res Function(_SelectAddressState) _then) = __$SelectAddressStateCopyWithImpl;
@override @useResult
$Res call({
 bool isSearching, bool isSearchLoading, bool isChoosing, List<Place> searchedPlaces, TextEditingController? textController, GoogleMapController? mapController, LocationData? location
});




}
/// @nodoc
class __$SelectAddressStateCopyWithImpl<$Res>
    implements _$SelectAddressStateCopyWith<$Res> {
  __$SelectAddressStateCopyWithImpl(this._self, this._then);

  final _SelectAddressState _self;
  final $Res Function(_SelectAddressState) _then;

/// Create a copy of SelectAddressState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isSearching = null,Object? isSearchLoading = null,Object? isChoosing = null,Object? searchedPlaces = null,Object? textController = freezed,Object? mapController = freezed,Object? location = freezed,}) {
  return _then(_SelectAddressState(
isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,isSearchLoading: null == isSearchLoading ? _self.isSearchLoading : isSearchLoading // ignore: cast_nullable_to_non_nullable
as bool,isChoosing: null == isChoosing ? _self.isChoosing : isChoosing // ignore: cast_nullable_to_non_nullable
as bool,searchedPlaces: null == searchedPlaces ? _self._searchedPlaces : searchedPlaces // ignore: cast_nullable_to_non_nullable
as List<Place>,textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,mapController: freezed == mapController ? _self.mapController : mapController // ignore: cast_nullable_to_non_nullable
as GoogleMapController?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData?,
  ));
}


}

// dart format on
