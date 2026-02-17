// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_units_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateFoodUnitsState {

 bool get isLoading; List<UnitData> get units; int get activeIndex; TextEditingController? get unitController;
/// Create a copy of CreateFoodUnitsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFoodUnitsStateCopyWith<CreateFoodUnitsState> get copyWith => _$CreateFoodUnitsStateCopyWithImpl<CreateFoodUnitsState>(this as CreateFoodUnitsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFoodUnitsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.units, units)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.unitController, unitController) || other.unitController == unitController));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(units),activeIndex,unitController);

@override
String toString() {
  return 'CreateFoodUnitsState(isLoading: $isLoading, units: $units, activeIndex: $activeIndex, unitController: $unitController)';
}


}

/// @nodoc
abstract mixin class $CreateFoodUnitsStateCopyWith<$Res>  {
  factory $CreateFoodUnitsStateCopyWith(CreateFoodUnitsState value, $Res Function(CreateFoodUnitsState) _then) = _$CreateFoodUnitsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<UnitData> units, int activeIndex, TextEditingController? unitController
});




}
/// @nodoc
class _$CreateFoodUnitsStateCopyWithImpl<$Res>
    implements $CreateFoodUnitsStateCopyWith<$Res> {
  _$CreateFoodUnitsStateCopyWithImpl(this._self, this._then);

  final CreateFoodUnitsState _self;
  final $Res Function(CreateFoodUnitsState) _then;

/// Create a copy of CreateFoodUnitsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? units = null,Object? activeIndex = null,Object? unitController = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as List<UnitData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,unitController: freezed == unitController ? _self.unitController : unitController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateFoodUnitsState].
extension CreateFoodUnitsStatePatterns on CreateFoodUnitsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFoodUnitsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFoodUnitsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFoodUnitsState value)  $default,){
final _that = this;
switch (_that) {
case _CreateFoodUnitsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFoodUnitsState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFoodUnitsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<UnitData> units,  int activeIndex,  TextEditingController? unitController)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFoodUnitsState() when $default != null:
return $default(_that.isLoading,_that.units,_that.activeIndex,_that.unitController);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<UnitData> units,  int activeIndex,  TextEditingController? unitController)  $default,) {final _that = this;
switch (_that) {
case _CreateFoodUnitsState():
return $default(_that.isLoading,_that.units,_that.activeIndex,_that.unitController);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<UnitData> units,  int activeIndex,  TextEditingController? unitController)?  $default,) {final _that = this;
switch (_that) {
case _CreateFoodUnitsState() when $default != null:
return $default(_that.isLoading,_that.units,_that.activeIndex,_that.unitController);case _:
  return null;

}
}

}

/// @nodoc


class _CreateFoodUnitsState extends CreateFoodUnitsState {
  const _CreateFoodUnitsState({this.isLoading = false, final  List<UnitData> units = const [], this.activeIndex = 0, this.unitController}): _units = units,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<UnitData> _units;
@override@JsonKey() List<UnitData> get units {
  if (_units is EqualUnmodifiableListView) return _units;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_units);
}

@override@JsonKey() final  int activeIndex;
@override final  TextEditingController? unitController;

/// Create a copy of CreateFoodUnitsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFoodUnitsStateCopyWith<_CreateFoodUnitsState> get copyWith => __$CreateFoodUnitsStateCopyWithImpl<_CreateFoodUnitsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFoodUnitsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._units, _units)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.unitController, unitController) || other.unitController == unitController));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_units),activeIndex,unitController);

@override
String toString() {
  return 'CreateFoodUnitsState(isLoading: $isLoading, units: $units, activeIndex: $activeIndex, unitController: $unitController)';
}


}

/// @nodoc
abstract mixin class _$CreateFoodUnitsStateCopyWith<$Res> implements $CreateFoodUnitsStateCopyWith<$Res> {
  factory _$CreateFoodUnitsStateCopyWith(_CreateFoodUnitsState value, $Res Function(_CreateFoodUnitsState) _then) = __$CreateFoodUnitsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<UnitData> units, int activeIndex, TextEditingController? unitController
});




}
/// @nodoc
class __$CreateFoodUnitsStateCopyWithImpl<$Res>
    implements _$CreateFoodUnitsStateCopyWith<$Res> {
  __$CreateFoodUnitsStateCopyWithImpl(this._self, this._then);

  final _CreateFoodUnitsState _self;
  final $Res Function(_CreateFoodUnitsState) _then;

/// Create a copy of CreateFoodUnitsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? units = null,Object? activeIndex = null,Object? unitController = freezed,}) {
  return _then(_CreateFoodUnitsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,units: null == units ? _self._units : units // ignore: cast_nullable_to_non_nullable
as List<UnitData>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,unitController: freezed == unitController ? _self.unitController : unitController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}


}

// dart format on
