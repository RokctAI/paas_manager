// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extras_group_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExtrasGroupDetailsState {

 bool get isLoading; List<Extras> get extras;
/// Create a copy of ExtrasGroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtrasGroupDetailsStateCopyWith<ExtrasGroupDetailsState> get copyWith => _$ExtrasGroupDetailsStateCopyWithImpl<ExtrasGroupDetailsState>(this as ExtrasGroupDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtrasGroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.extras, extras));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(extras));

@override
String toString() {
  return 'ExtrasGroupDetailsState(isLoading: $isLoading, extras: $extras)';
}


}

/// @nodoc
abstract mixin class $ExtrasGroupDetailsStateCopyWith<$Res>  {
  factory $ExtrasGroupDetailsStateCopyWith(ExtrasGroupDetailsState value, $Res Function(ExtrasGroupDetailsState) _then) = _$ExtrasGroupDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Extras> extras
});




}
/// @nodoc
class _$ExtrasGroupDetailsStateCopyWithImpl<$Res>
    implements $ExtrasGroupDetailsStateCopyWith<$Res> {
  _$ExtrasGroupDetailsStateCopyWithImpl(this._self, this._then);

  final ExtrasGroupDetailsState _self;
  final $Res Function(ExtrasGroupDetailsState) _then;

/// Create a copy of ExtrasGroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? extras = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as List<Extras>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtrasGroupDetailsState].
extension ExtrasGroupDetailsStatePatterns on ExtrasGroupDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtrasGroupDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtrasGroupDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtrasGroupDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _ExtrasGroupDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtrasGroupDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _ExtrasGroupDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Extras> extras)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtrasGroupDetailsState() when $default != null:
return $default(_that.isLoading,_that.extras);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Extras> extras)  $default,) {final _that = this;
switch (_that) {
case _ExtrasGroupDetailsState():
return $default(_that.isLoading,_that.extras);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Extras> extras)?  $default,) {final _that = this;
switch (_that) {
case _ExtrasGroupDetailsState() when $default != null:
return $default(_that.isLoading,_that.extras);case _:
  return null;

}
}

}

/// @nodoc


class _ExtrasGroupDetailsState extends ExtrasGroupDetailsState {
  const _ExtrasGroupDetailsState({this.isLoading = false, final  List<Extras> extras = const []}): _extras = extras,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<Extras> _extras;
@override@JsonKey() List<Extras> get extras {
  if (_extras is EqualUnmodifiableListView) return _extras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extras);
}


/// Create a copy of ExtrasGroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtrasGroupDetailsStateCopyWith<_ExtrasGroupDetailsState> get copyWith => __$ExtrasGroupDetailsStateCopyWithImpl<_ExtrasGroupDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtrasGroupDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._extras, _extras));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_extras));

@override
String toString() {
  return 'ExtrasGroupDetailsState(isLoading: $isLoading, extras: $extras)';
}


}

/// @nodoc
abstract mixin class _$ExtrasGroupDetailsStateCopyWith<$Res> implements $ExtrasGroupDetailsStateCopyWith<$Res> {
  factory _$ExtrasGroupDetailsStateCopyWith(_ExtrasGroupDetailsState value, $Res Function(_ExtrasGroupDetailsState) _then) = __$ExtrasGroupDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Extras> extras
});




}
/// @nodoc
class __$ExtrasGroupDetailsStateCopyWithImpl<$Res>
    implements _$ExtrasGroupDetailsStateCopyWith<$Res> {
  __$ExtrasGroupDetailsStateCopyWithImpl(this._self, this._then);

  final _ExtrasGroupDetailsState _self;
  final $Res Function(_ExtrasGroupDetailsState) _then;

/// Create a copy of ExtrasGroupDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? extras = null,}) {
  return _then(_ExtrasGroupDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,extras: null == extras ? _self._extras : extras // ignore: cast_nullable_to_non_nullable
as List<Extras>,
  ));
}


}

// dart format on
