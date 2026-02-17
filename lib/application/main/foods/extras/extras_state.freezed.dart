// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extras_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExtrasState {

 bool get isLoading; bool get isSaving; List<Group> get groups;
/// Create a copy of ExtrasState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtrasStateCopyWith<ExtrasState> get copyWith => _$ExtrasStateCopyWithImpl<ExtrasState>(this as ExtrasState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtrasState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other.groups, groups));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'ExtrasState(isLoading: $isLoading, isSaving: $isSaving, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $ExtrasStateCopyWith<$Res>  {
  factory $ExtrasStateCopyWith(ExtrasState value, $Res Function(ExtrasState) _then) = _$ExtrasStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSaving, List<Group> groups
});




}
/// @nodoc
class _$ExtrasStateCopyWithImpl<$Res>
    implements $ExtrasStateCopyWith<$Res> {
  _$ExtrasStateCopyWithImpl(this._self, this._then);

  final ExtrasState _self;
  final $Res Function(ExtrasState) _then;

/// Create a copy of ExtrasState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSaving = null,Object? groups = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtrasState].
extension ExtrasStatePatterns on ExtrasState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtrasState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtrasState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtrasState value)  $default,){
final _that = this;
switch (_that) {
case _ExtrasState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtrasState value)?  $default,){
final _that = this;
switch (_that) {
case _ExtrasState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  List<Group> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtrasState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  List<Group> groups)  $default,) {final _that = this;
switch (_that) {
case _ExtrasState():
return $default(_that.isLoading,_that.isSaving,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSaving,  List<Group> groups)?  $default,) {final _that = this;
switch (_that) {
case _ExtrasState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.groups);case _:
  return null;

}
}

}

/// @nodoc


class _ExtrasState extends ExtrasState {
  const _ExtrasState({this.isLoading = false, this.isSaving = false, final  List<Group> groups = const []}): _groups = groups,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
 final  List<Group> _groups;
@override@JsonKey() List<Group> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of ExtrasState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtrasStateCopyWith<_ExtrasState> get copyWith => __$ExtrasStateCopyWithImpl<_ExtrasState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtrasState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other._groups, _groups));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'ExtrasState(isLoading: $isLoading, isSaving: $isSaving, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$ExtrasStateCopyWith<$Res> implements $ExtrasStateCopyWith<$Res> {
  factory _$ExtrasStateCopyWith(_ExtrasState value, $Res Function(_ExtrasState) _then) = __$ExtrasStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSaving, List<Group> groups
});




}
/// @nodoc
class __$ExtrasStateCopyWithImpl<$Res>
    implements _$ExtrasStateCopyWith<$Res> {
  __$ExtrasStateCopyWithImpl(this._self, this._then);

  final _ExtrasState _self;
  final $Res Function(_ExtrasState) _then;

/// Create a copy of ExtrasState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSaving = null,Object? groups = null,}) {
  return _then(_ExtrasState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}


}

// dart format on
