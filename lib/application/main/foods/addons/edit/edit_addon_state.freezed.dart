// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_addon_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditAddonState {

 bool get isLoading; Map<String, List<String>> get mapOfDesc;
/// Create a copy of EditAddonState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditAddonStateCopyWith<EditAddonState> get copyWith => _$EditAddonStateCopyWithImpl<EditAddonState>(this as EditAddonState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditAddonState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.mapOfDesc, mapOfDesc));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(mapOfDesc));

@override
String toString() {
  return 'EditAddonState(isLoading: $isLoading, mapOfDesc: $mapOfDesc)';
}


}

/// @nodoc
abstract mixin class $EditAddonStateCopyWith<$Res>  {
  factory $EditAddonStateCopyWith(EditAddonState value, $Res Function(EditAddonState) _then) = _$EditAddonStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, Map<String, List<String>> mapOfDesc
});




}
/// @nodoc
class _$EditAddonStateCopyWithImpl<$Res>
    implements $EditAddonStateCopyWith<$Res> {
  _$EditAddonStateCopyWithImpl(this._self, this._then);

  final EditAddonState _self;
  final $Res Function(EditAddonState) _then;

/// Create a copy of EditAddonState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? mapOfDesc = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,mapOfDesc: null == mapOfDesc ? _self.mapOfDesc : mapOfDesc // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}

}


/// Adds pattern-matching-related methods to [EditAddonState].
extension EditAddonStatePatterns on EditAddonState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditAddonState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditAddonState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditAddonState value)  $default,){
final _that = this;
switch (_that) {
case _EditAddonState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditAddonState value)?  $default,){
final _that = this;
switch (_that) {
case _EditAddonState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  Map<String, List<String>> mapOfDesc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditAddonState() when $default != null:
return $default(_that.isLoading,_that.mapOfDesc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  Map<String, List<String>> mapOfDesc)  $default,) {final _that = this;
switch (_that) {
case _EditAddonState():
return $default(_that.isLoading,_that.mapOfDesc);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  Map<String, List<String>> mapOfDesc)?  $default,) {final _that = this;
switch (_that) {
case _EditAddonState() when $default != null:
return $default(_that.isLoading,_that.mapOfDesc);case _:
  return null;

}
}

}

/// @nodoc


class _EditAddonState extends EditAddonState {
  const _EditAddonState({this.isLoading = false, final  Map<String, List<String>> mapOfDesc = const {}}): _mapOfDesc = mapOfDesc,super._();
  

@override@JsonKey() final  bool isLoading;
 final  Map<String, List<String>> _mapOfDesc;
@override@JsonKey() Map<String, List<String>> get mapOfDesc {
  if (_mapOfDesc is EqualUnmodifiableMapView) return _mapOfDesc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_mapOfDesc);
}


/// Create a copy of EditAddonState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditAddonStateCopyWith<_EditAddonState> get copyWith => __$EditAddonStateCopyWithImpl<_EditAddonState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditAddonState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._mapOfDesc, _mapOfDesc));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_mapOfDesc));

@override
String toString() {
  return 'EditAddonState(isLoading: $isLoading, mapOfDesc: $mapOfDesc)';
}


}

/// @nodoc
abstract mixin class _$EditAddonStateCopyWith<$Res> implements $EditAddonStateCopyWith<$Res> {
  factory _$EditAddonStateCopyWith(_EditAddonState value, $Res Function(_EditAddonState) _then) = __$EditAddonStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, Map<String, List<String>> mapOfDesc
});




}
/// @nodoc
class __$EditAddonStateCopyWithImpl<$Res>
    implements _$EditAddonStateCopyWith<$Res> {
  __$EditAddonStateCopyWithImpl(this._self, this._then);

  final _EditAddonState _self;
  final $Res Function(_EditAddonState) _then;

/// Create a copy of EditAddonState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? mapOfDesc = null,}) {
  return _then(_EditAddonState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,mapOfDesc: null == mapOfDesc ? _self._mapOfDesc : mapOfDesc // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,
  ));
}


}

// dart format on
