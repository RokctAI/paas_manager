// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_food_kitchens_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditFoodKitchensState {

 bool get isLoading; List<KitchenModel> get kitchens; int get activeIndex; TextEditingController? get kitchenController; KitchenModel? get foodKitchen;
/// Create a copy of EditFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditFoodKitchensStateCopyWith<EditFoodKitchensState> get copyWith => _$EditFoodKitchensStateCopyWithImpl<EditFoodKitchensState>(this as EditFoodKitchensState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditFoodKitchensState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.kitchens, kitchens)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.kitchenController, kitchenController) || other.kitchenController == kitchenController)&&(identical(other.foodKitchen, foodKitchen) || other.foodKitchen == foodKitchen));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(kitchens),activeIndex,kitchenController,foodKitchen);

@override
String toString() {
  return 'EditFoodKitchensState(isLoading: $isLoading, kitchens: $kitchens, activeIndex: $activeIndex, kitchenController: $kitchenController, foodKitchen: $foodKitchen)';
}


}

/// @nodoc
abstract mixin class $EditFoodKitchensStateCopyWith<$Res>  {
  factory $EditFoodKitchensStateCopyWith(EditFoodKitchensState value, $Res Function(EditFoodKitchensState) _then) = _$EditFoodKitchensStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<KitchenModel> kitchens, int activeIndex, TextEditingController? kitchenController, KitchenModel? foodKitchen
});




}
/// @nodoc
class _$EditFoodKitchensStateCopyWithImpl<$Res>
    implements $EditFoodKitchensStateCopyWith<$Res> {
  _$EditFoodKitchensStateCopyWithImpl(this._self, this._then);

  final EditFoodKitchensState _self;
  final $Res Function(EditFoodKitchensState) _then;

/// Create a copy of EditFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? kitchens = null,Object? activeIndex = null,Object? kitchenController = freezed,Object? foodKitchen = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,kitchens: null == kitchens ? _self.kitchens : kitchens // ignore: cast_nullable_to_non_nullable
as List<KitchenModel>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,kitchenController: freezed == kitchenController ? _self.kitchenController : kitchenController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,foodKitchen: freezed == foodKitchen ? _self.foodKitchen : foodKitchen // ignore: cast_nullable_to_non_nullable
as KitchenModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditFoodKitchensState].
extension EditFoodKitchensStatePatterns on EditFoodKitchensState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditFoodKitchensState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditFoodKitchensState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditFoodKitchensState value)  $default,){
final _that = this;
switch (_that) {
case _EditFoodKitchensState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditFoodKitchensState value)?  $default,){
final _that = this;
switch (_that) {
case _EditFoodKitchensState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<KitchenModel> kitchens,  int activeIndex,  TextEditingController? kitchenController,  KitchenModel? foodKitchen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditFoodKitchensState() when $default != null:
return $default(_that.isLoading,_that.kitchens,_that.activeIndex,_that.kitchenController,_that.foodKitchen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<KitchenModel> kitchens,  int activeIndex,  TextEditingController? kitchenController,  KitchenModel? foodKitchen)  $default,) {final _that = this;
switch (_that) {
case _EditFoodKitchensState():
return $default(_that.isLoading,_that.kitchens,_that.activeIndex,_that.kitchenController,_that.foodKitchen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<KitchenModel> kitchens,  int activeIndex,  TextEditingController? kitchenController,  KitchenModel? foodKitchen)?  $default,) {final _that = this;
switch (_that) {
case _EditFoodKitchensState() when $default != null:
return $default(_that.isLoading,_that.kitchens,_that.activeIndex,_that.kitchenController,_that.foodKitchen);case _:
  return null;

}
}

}

/// @nodoc


class _EditFoodKitchensState extends EditFoodKitchensState {
  const _EditFoodKitchensState({this.isLoading = false, final  List<KitchenModel> kitchens = const [], this.activeIndex = 0, this.kitchenController, this.foodKitchen}): _kitchens = kitchens,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<KitchenModel> _kitchens;
@override@JsonKey() List<KitchenModel> get kitchens {
  if (_kitchens is EqualUnmodifiableListView) return _kitchens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kitchens);
}

@override@JsonKey() final  int activeIndex;
@override final  TextEditingController? kitchenController;
@override final  KitchenModel? foodKitchen;

/// Create a copy of EditFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditFoodKitchensStateCopyWith<_EditFoodKitchensState> get copyWith => __$EditFoodKitchensStateCopyWithImpl<_EditFoodKitchensState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditFoodKitchensState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._kitchens, _kitchens)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.kitchenController, kitchenController) || other.kitchenController == kitchenController)&&(identical(other.foodKitchen, foodKitchen) || other.foodKitchen == foodKitchen));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_kitchens),activeIndex,kitchenController,foodKitchen);

@override
String toString() {
  return 'EditFoodKitchensState(isLoading: $isLoading, kitchens: $kitchens, activeIndex: $activeIndex, kitchenController: $kitchenController, foodKitchen: $foodKitchen)';
}


}

/// @nodoc
abstract mixin class _$EditFoodKitchensStateCopyWith<$Res> implements $EditFoodKitchensStateCopyWith<$Res> {
  factory _$EditFoodKitchensStateCopyWith(_EditFoodKitchensState value, $Res Function(_EditFoodKitchensState) _then) = __$EditFoodKitchensStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<KitchenModel> kitchens, int activeIndex, TextEditingController? kitchenController, KitchenModel? foodKitchen
});




}
/// @nodoc
class __$EditFoodKitchensStateCopyWithImpl<$Res>
    implements _$EditFoodKitchensStateCopyWith<$Res> {
  __$EditFoodKitchensStateCopyWithImpl(this._self, this._then);

  final _EditFoodKitchensState _self;
  final $Res Function(_EditFoodKitchensState) _then;

/// Create a copy of EditFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? kitchens = null,Object? activeIndex = null,Object? kitchenController = freezed,Object? foodKitchen = freezed,}) {
  return _then(_EditFoodKitchensState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,kitchens: null == kitchens ? _self._kitchens : kitchens // ignore: cast_nullable_to_non_nullable
as List<KitchenModel>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,kitchenController: freezed == kitchenController ? _self.kitchenController : kitchenController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,foodKitchen: freezed == foodKitchen ? _self.foodKitchen : foodKitchen // ignore: cast_nullable_to_non_nullable
as KitchenModel?,
  ));
}


}

// dart format on
