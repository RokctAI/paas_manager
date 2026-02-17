// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_extras_group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateExtrasGroupState {

 bool get isLoading;
/// Create a copy of CreateExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateExtrasGroupStateCopyWith<CreateExtrasGroupState> get copyWith => _$CreateExtrasGroupStateCopyWithImpl<CreateExtrasGroupState>(this as CreateExtrasGroupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateExtrasGroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'CreateExtrasGroupState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $CreateExtrasGroupStateCopyWith<$Res>  {
  factory $CreateExtrasGroupStateCopyWith(CreateExtrasGroupState value, $Res Function(CreateExtrasGroupState) _then) = _$CreateExtrasGroupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class _$CreateExtrasGroupStateCopyWithImpl<$Res>
    implements $CreateExtrasGroupStateCopyWith<$Res> {
  _$CreateExtrasGroupStateCopyWithImpl(this._self, this._then);

  final CreateExtrasGroupState _self;
  final $Res Function(CreateExtrasGroupState) _then;

/// Create a copy of CreateExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateExtrasGroupState].
extension CreateExtrasGroupStatePatterns on CreateExtrasGroupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateExtrasGroupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateExtrasGroupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateExtrasGroupState value)  $default,){
final _that = this;
switch (_that) {
case _CreateExtrasGroupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateExtrasGroupState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateExtrasGroupState() when $default != null:
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
case _CreateExtrasGroupState() when $default != null:
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
case _CreateExtrasGroupState():
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
case _CreateExtrasGroupState() when $default != null:
return $default(_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _CreateExtrasGroupState extends CreateExtrasGroupState {
  const _CreateExtrasGroupState({this.isLoading = false}): super._();
  

@override@JsonKey() final  bool isLoading;

/// Create a copy of CreateExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateExtrasGroupStateCopyWith<_CreateExtrasGroupState> get copyWith => __$CreateExtrasGroupStateCopyWithImpl<_CreateExtrasGroupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateExtrasGroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'CreateExtrasGroupState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$CreateExtrasGroupStateCopyWith<$Res> implements $CreateExtrasGroupStateCopyWith<$Res> {
  factory _$CreateExtrasGroupStateCopyWith(_CreateExtrasGroupState value, $Res Function(_CreateExtrasGroupState) _then) = __$CreateExtrasGroupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class __$CreateExtrasGroupStateCopyWithImpl<$Res>
    implements _$CreateExtrasGroupStateCopyWith<$Res> {
  __$CreateExtrasGroupStateCopyWithImpl(this._self, this._then);

  final _CreateExtrasGroupState _self;
  final $Res Function(_CreateExtrasGroupState) _then;

/// Create a copy of CreateExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,}) {
  return _then(_CreateExtrasGroupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
