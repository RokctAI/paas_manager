// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'addons_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddonsState {

 bool get isLoading; List<ProductData> get addons;
/// Create a copy of AddonsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddonsStateCopyWith<AddonsState> get copyWith => _$AddonsStateCopyWithImpl<AddonsState>(this as AddonsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddonsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.addons, addons));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(addons));

@override
String toString() {
  return 'AddonsState(isLoading: $isLoading, addons: $addons)';
}


}

/// @nodoc
abstract mixin class $AddonsStateCopyWith<$Res>  {
  factory $AddonsStateCopyWith(AddonsState value, $Res Function(AddonsState) _then) = _$AddonsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ProductData> addons
});




}
/// @nodoc
class _$AddonsStateCopyWithImpl<$Res>
    implements $AddonsStateCopyWith<$Res> {
  _$AddonsStateCopyWithImpl(this._self, this._then);

  final AddonsState _self;
  final $Res Function(AddonsState) _then;

/// Create a copy of AddonsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? addons = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,addons: null == addons ? _self.addons : addons // ignore: cast_nullable_to_non_nullable
as List<ProductData>,
  ));
}

}


/// Adds pattern-matching-related methods to [AddonsState].
extension AddonsStatePatterns on AddonsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddonsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddonsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddonsState value)  $default,){
final _that = this;
switch (_that) {
case _AddonsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddonsState value)?  $default,){
final _that = this;
switch (_that) {
case _AddonsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductData> addons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddonsState() when $default != null:
return $default(_that.isLoading,_that.addons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ProductData> addons)  $default,) {final _that = this;
switch (_that) {
case _AddonsState():
return $default(_that.isLoading,_that.addons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ProductData> addons)?  $default,) {final _that = this;
switch (_that) {
case _AddonsState() when $default != null:
return $default(_that.isLoading,_that.addons);case _:
  return null;

}
}

}

/// @nodoc


class _AddonsState extends AddonsState {
  const _AddonsState({this.isLoading = false, final  List<ProductData> addons = const []}): _addons = addons,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<ProductData> _addons;
@override@JsonKey() List<ProductData> get addons {
  if (_addons is EqualUnmodifiableListView) return _addons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addons);
}


/// Create a copy of AddonsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddonsStateCopyWith<_AddonsState> get copyWith => __$AddonsStateCopyWithImpl<_AddonsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddonsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._addons, _addons));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_addons));

@override
String toString() {
  return 'AddonsState(isLoading: $isLoading, addons: $addons)';
}


}

/// @nodoc
abstract mixin class _$AddonsStateCopyWith<$Res> implements $AddonsStateCopyWith<$Res> {
  factory _$AddonsStateCopyWith(_AddonsState value, $Res Function(_AddonsState) _then) = __$AddonsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ProductData> addons
});




}
/// @nodoc
class __$AddonsStateCopyWithImpl<$Res>
    implements _$AddonsStateCopyWith<$Res> {
  __$AddonsStateCopyWithImpl(this._self, this._then);

  final _AddonsState _self;
  final $Res Function(_AddonsState) _then;

/// Create a copy of AddonsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? addons = null,}) {
  return _then(_AddonsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,addons: null == addons ? _self._addons : addons // ignore: cast_nullable_to_non_nullable
as List<ProductData>,
  ));
}


}

// dart format on
