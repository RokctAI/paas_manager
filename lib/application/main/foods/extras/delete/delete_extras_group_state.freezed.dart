// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_extras_group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DeleteExtrasGroupState {

 bool get isLoading;
/// Create a copy of DeleteExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteExtrasGroupStateCopyWith<DeleteExtrasGroupState> get copyWith => _$DeleteExtrasGroupStateCopyWithImpl<DeleteExtrasGroupState>(this as DeleteExtrasGroupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteExtrasGroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'DeleteExtrasGroupState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $DeleteExtrasGroupStateCopyWith<$Res>  {
  factory $DeleteExtrasGroupStateCopyWith(DeleteExtrasGroupState value, $Res Function(DeleteExtrasGroupState) _then) = _$DeleteExtrasGroupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class _$DeleteExtrasGroupStateCopyWithImpl<$Res>
    implements $DeleteExtrasGroupStateCopyWith<$Res> {
  _$DeleteExtrasGroupStateCopyWithImpl(this._self, this._then);

  final DeleteExtrasGroupState _self;
  final $Res Function(DeleteExtrasGroupState) _then;

/// Create a copy of DeleteExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DeleteExtrasGroupState].
extension DeleteExtrasGroupStatePatterns on DeleteExtrasGroupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeleteExtrasGroupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeleteExtrasGroupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeleteExtrasGroupState value)  $default,){
final _that = this;
switch (_that) {
case _DeleteExtrasGroupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeleteExtrasGroupState value)?  $default,){
final _that = this;
switch (_that) {
case _DeleteExtrasGroupState() when $default != null:
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
case _DeleteExtrasGroupState() when $default != null:
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
case _DeleteExtrasGroupState():
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
case _DeleteExtrasGroupState() when $default != null:
return $default(_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _DeleteExtrasGroupState extends DeleteExtrasGroupState {
  const _DeleteExtrasGroupState({this.isLoading = false}): super._();
  

@override@JsonKey() final  bool isLoading;

/// Create a copy of DeleteExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteExtrasGroupStateCopyWith<_DeleteExtrasGroupState> get copyWith => __$DeleteExtrasGroupStateCopyWithImpl<_DeleteExtrasGroupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteExtrasGroupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading);

@override
String toString() {
  return 'DeleteExtrasGroupState(isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$DeleteExtrasGroupStateCopyWith<$Res> implements $DeleteExtrasGroupStateCopyWith<$Res> {
  factory _$DeleteExtrasGroupStateCopyWith(_DeleteExtrasGroupState value, $Res Function(_DeleteExtrasGroupState) _then) = __$DeleteExtrasGroupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading
});




}
/// @nodoc
class __$DeleteExtrasGroupStateCopyWithImpl<$Res>
    implements _$DeleteExtrasGroupStateCopyWith<$Res> {
  __$DeleteExtrasGroupStateCopyWithImpl(this._self, this._then);

  final _DeleteExtrasGroupState _self;
  final $Res Function(_DeleteExtrasGroupState) _then;

/// Create a copy of DeleteExtrasGroupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,}) {
  return _then(_DeleteExtrasGroupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
