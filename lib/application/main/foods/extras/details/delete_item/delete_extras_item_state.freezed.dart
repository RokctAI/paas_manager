// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_extras_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeleteExtrasItemState {

 bool get isLoading;
/// Create a copy of DeleteExtrasItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteExtrasItemStateCopyWith<DeleteExtrasItemState> get copyWith => _$DeleteExtrasItemStateCopyWithImpl<DeleteExtrasItemState>(this as DeleteExtrasItemState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteExtrasItemState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'DeleteExtrasItemState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $DeleteExtrasItemStateCopyWith<$Res>  {
  factory $DeleteExtrasItemStateCopyWith(DeleteExtrasItemState value, $Res Function(DeleteExtrasItemState) _then) = _$DeleteExtrasItemStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class _$DeleteExtrasItemStateCopyWithImpl<$Res>
    implements $DeleteExtrasItemStateCopyWith<$Res> {
  _$DeleteExtrasItemStateCopyWithImpl(this._self, this._then);

  final DeleteExtrasItemState _self;
  final $Res Function(DeleteExtrasItemState) _then;

/// Create a copy of DeleteExtrasItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteExtrasItemState].
extension DeleteExtrasItemStatePatterns on DeleteExtrasItemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteExtrasItemState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteExtrasItemState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteExtrasItemState value)  $default,){
final _that = this;
switch (_that) {
case _DeleteExtrasItemState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteExtrasItemState value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteExtrasItemState() when $default != null:
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
case _DeleteExtrasItemState() when $default != null:
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
case _DeleteExtrasItemState():
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
case _DeleteExtrasItemState() when $default != null:
return $default(_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _DeleteExtrasItemState extends DeleteExtrasItemState {
  const _DeleteExtrasItemState({this.isLoading = false}): super._();
  

@override@JsonKey() final  bool isLoading;

/// Create a copy of DeleteExtrasItemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteExtrasItemStateCopyWith<_DeleteExtrasItemState> get copyWith => __$DeleteExtrasItemStateCopyWithImpl<_DeleteExtrasItemState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteExtrasItemState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'DeleteExtrasItemState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$DeleteExtrasItemStateCopyWith<$Res> implements $DeleteExtrasItemStateCopyWith<$Res> {
  factory _$DeleteExtrasItemStateCopyWith(_DeleteExtrasItemState value, $Res Function(_DeleteExtrasItemState) _then) = __$DeleteExtrasItemStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class __$DeleteExtrasItemStateCopyWithImpl<$Res>
    implements _$DeleteExtrasItemStateCopyWith<$Res> {
  __$DeleteExtrasItemStateCopyWithImpl(this._self, this._then);

  final _DeleteExtrasItemState _self;
  final $Res Function(_DeleteExtrasItemState) _then;

/// Create a copy of DeleteExtrasItemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,}) {
  return _then(_DeleteExtrasItemState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
