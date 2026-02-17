// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_order_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateOrderState {

 bool get isCreating;
/// Create a copy of CreateOrderState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateOrderStateCopyWith<CreateOrderState> get copyWith => _$CreateOrderStateCopyWithImpl<CreateOrderState>(this as CreateOrderState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateOrderState&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating));
}


@override
int get hashCode => Object.hash(runtimeType,isCreating);

@override
String toString() {
  return 'CreateOrderState(isCreating: $isCreating)';
}


}

/// @nodoc
abstract mixin class $CreateOrderStateCopyWith<$Res>  {
  factory $CreateOrderStateCopyWith(CreateOrderState value, $Res Function(CreateOrderState) _then) = _$CreateOrderStateCopyWithImpl;
@useResult
$Res call({
 bool isCreating
});




}
/// @nodoc
class _$CreateOrderStateCopyWithImpl<$Res>
    implements $CreateOrderStateCopyWith<$Res> {
  _$CreateOrderStateCopyWithImpl(this._self, this._then);

  final CreateOrderState _self;
  final $Res Function(CreateOrderState) _then;

/// Create a copy of CreateOrderState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isCreating = null,}) {
  return _then(_self.copyWith(
isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateOrderState].
extension CreateOrderStatePatterns on CreateOrderState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateOrderState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateOrderState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateOrderState value)  $default,){
final _that = this;
switch (_that) {
case _CreateOrderState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateOrderState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateOrderState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isCreating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateOrderState() when $default != null:
return $default(_that.isCreating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isCreating)  $default,) {final _that = this;
switch (_that) {
case _CreateOrderState():
return $default(_that.isCreating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isCreating)?  $default,) {final _that = this;
switch (_that) {
case _CreateOrderState() when $default != null:
return $default(_that.isCreating);case _:
  return null;

}
}

}

/// @nodoc


class _CreateOrderState extends CreateOrderState {
  const _CreateOrderState({this.isCreating = false}): super._();
  

@override@JsonKey() final  bool isCreating;

/// Create a copy of CreateOrderState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateOrderStateCopyWith<_CreateOrderState> get copyWith => __$CreateOrderStateCopyWithImpl<_CreateOrderState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateOrderState&&(identical(other.isCreating, isCreating) || other.isCreating == isCreating));
}


@override
int get hashCode => Object.hash(runtimeType,isCreating);

@override
String toString() {
  return 'CreateOrderState(isCreating: $isCreating)';
}


}

/// @nodoc
abstract mixin class _$CreateOrderStateCopyWith<$Res> implements $CreateOrderStateCopyWith<$Res> {
  factory _$CreateOrderStateCopyWith(_CreateOrderState value, $Res Function(_CreateOrderState) _then) = __$CreateOrderStateCopyWithImpl;
@override @useResult
$Res call({
 bool isCreating
});




}
/// @nodoc
class __$CreateOrderStateCopyWithImpl<$Res>
    implements _$CreateOrderStateCopyWith<$Res> {
  __$CreateOrderStateCopyWithImpl(this._self, this._then);

  final _CreateOrderState _self;
  final $Res Function(_CreateOrderState) _then;

/// Create a copy of CreateOrderState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCreating = null,}) {
  return _then(_CreateOrderState(
isCreating: null == isCreating ? _self.isCreating : isCreating // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
