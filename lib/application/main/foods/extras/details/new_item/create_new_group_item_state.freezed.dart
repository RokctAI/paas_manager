// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_new_group_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateNewGroupItemState {

 bool get isLoading;
/// Create a copy of CreateNewGroupItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateNewGroupItemStateCopyWith<CreateNewGroupItemState> get copyWith => _$CreateNewGroupItemStateCopyWithImpl<CreateNewGroupItemState>(this as CreateNewGroupItemState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateNewGroupItemState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'CreateNewGroupItemState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $CreateNewGroupItemStateCopyWith<$Res>  {
  factory $CreateNewGroupItemStateCopyWith(CreateNewGroupItemState value, $Res Function(CreateNewGroupItemState) _then) = _$CreateNewGroupItemStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class _$CreateNewGroupItemStateCopyWithImpl<$Res>
    implements $CreateNewGroupItemStateCopyWith<$Res> {
  _$CreateNewGroupItemStateCopyWithImpl(this._self, this._then);

  final CreateNewGroupItemState _self;
  final $Res Function(CreateNewGroupItemState) _then;

/// Create a copy of CreateNewGroupItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateNewGroupItemState].
extension CreateNewGroupItemStatePatterns on CreateNewGroupItemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateNewGroupItemState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateNewGroupItemState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateNewGroupItemState value)  $default,){
final _that = this;
switch (_that) {
case _CreateNewGroupItemState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateNewGroupItemState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateNewGroupItemState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateNewGroupItemState() when $default != null:
return $default(_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _CreateNewGroupItemState():
return $default(_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _CreateNewGroupItemState() when $default != null:
return $default(_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _CreateNewGroupItemState extends CreateNewGroupItemState {
  const _CreateNewGroupItemState({this.isLoading = false}): super._();
  

@override@JsonKey() final  bool isLoading;

/// Create a copy of CreateNewGroupItemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateNewGroupItemStateCopyWith<_CreateNewGroupItemState> get copyWith => __$CreateNewGroupItemStateCopyWithImpl<_CreateNewGroupItemState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateNewGroupItemState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'CreateNewGroupItemState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$CreateNewGroupItemStateCopyWith<$Res> implements $CreateNewGroupItemStateCopyWith<$Res> {
  factory _$CreateNewGroupItemStateCopyWith(_CreateNewGroupItemState value, $Res Function(_CreateNewGroupItemState) _then) = __$CreateNewGroupItemStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class __$CreateNewGroupItemStateCopyWithImpl<$Res>
    implements _$CreateNewGroupItemStateCopyWith<$Res> {
  __$CreateNewGroupItemStateCopyWithImpl(this._self, this._then);

  final _CreateNewGroupItemState _self;
  final $Res Function(_CreateNewGroupItemState) _then;

/// Create a copy of CreateNewGroupItemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,}) {
  return _then(_CreateNewGroupItemState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
