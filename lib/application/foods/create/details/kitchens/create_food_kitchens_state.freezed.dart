// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_food_kitchens_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateFoodKitchensState {

 bool get isLoading; List<KitchenModel> get kitchens; int get activeIndex; TextEditingController? get kitchenController;
/// Create a copy of CreateFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFoodKitchensStateCopyWith<CreateFoodKitchensState> get copyWith => _$CreateFoodKitchensStateCopyWithImpl<CreateFoodKitchensState>(this as CreateFoodKitchensState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFoodKitchensState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.kitchens, kitchens)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.kitchenController, kitchenController) || other.kitchenController == kitchenController));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(kitchens),activeIndex,kitchenController);

@override
String toString() {
  return 'CreateFoodKitchensState(isLoading: $isLoading, kitchens: $kitchens, activeIndex: $activeIndex, kitchenController: $kitchenController)';
}


}

/// @nodoc
abstract mixin class $CreateFoodKitchensStateCopyWith<$Res>  {
  factory $CreateFoodKitchensStateCopyWith(CreateFoodKitchensState value, $Res Function(CreateFoodKitchensState) _then) = _$CreateFoodKitchensStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<KitchenModel> kitchens, int activeIndex, TextEditingController? kitchenController
});




}
/// @nodoc
class _$CreateFoodKitchensStateCopyWithImpl<$Res>
    implements $CreateFoodKitchensStateCopyWith<$Res> {
  _$CreateFoodKitchensStateCopyWithImpl(this._self, this._then);

  final CreateFoodKitchensState _self;
  final $Res Function(CreateFoodKitchensState) _then;

/// Create a copy of CreateFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? kitchens = null,Object? activeIndex = null,Object? kitchenController = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,kitchens: null == kitchens ? _self.kitchens : kitchens // ignore: cast_nullable_to_non_nullable
as List<KitchenModel>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,kitchenController: freezed == kitchenController ? _self.kitchenController : kitchenController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateFoodKitchensState].
extension CreateFoodKitchensStatePatterns on CreateFoodKitchensState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFoodKitchensState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFoodKitchensState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFoodKitchensState value)  $default,){
final _that = this;
switch (_that) {
case _CreateFoodKitchensState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFoodKitchensState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFoodKitchensState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<KitchenModel> kitchens,  int activeIndex,  TextEditingController? kitchenController)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFoodKitchensState() when $default != null:
return $default(_that.isLoading,_that.kitchens,_that.activeIndex,_that.kitchenController);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<KitchenModel> kitchens,  int activeIndex,  TextEditingController? kitchenController)  $default,) {final _that = this;
switch (_that) {
case _CreateFoodKitchensState():
return $default(_that.isLoading,_that.kitchens,_that.activeIndex,_that.kitchenController);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<KitchenModel> kitchens,  int activeIndex,  TextEditingController? kitchenController)?  $default,) {final _that = this;
switch (_that) {
case _CreateFoodKitchensState() when $default != null:
return $default(_that.isLoading,_that.kitchens,_that.activeIndex,_that.kitchenController);case _:
  return null;

}
}

}

/// @nodoc


class _CreateFoodKitchensState extends CreateFoodKitchensState {
  const _CreateFoodKitchensState({this.isLoading = false, final  List<KitchenModel> kitchens = const [], this.activeIndex = 0, this.kitchenController}): _kitchens = kitchens,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<KitchenModel> _kitchens;
@override@JsonKey() List<KitchenModel> get kitchens {
  if (_kitchens is EqualUnmodifiableListView) return _kitchens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kitchens);
}

@override@JsonKey() final  int activeIndex;
@override final  TextEditingController? kitchenController;

/// Create a copy of CreateFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFoodKitchensStateCopyWith<_CreateFoodKitchensState> get copyWith => __$CreateFoodKitchensStateCopyWithImpl<_CreateFoodKitchensState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFoodKitchensState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._kitchens, _kitchens)&&(identical(other.activeIndex, activeIndex) || other.activeIndex == activeIndex)&&(identical(other.kitchenController, kitchenController) || other.kitchenController == kitchenController));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_kitchens),activeIndex,kitchenController);

@override
String toString() {
  return 'CreateFoodKitchensState(isLoading: $isLoading, kitchens: $kitchens, activeIndex: $activeIndex, kitchenController: $kitchenController)';
}


}

/// @nodoc
abstract mixin class _$CreateFoodKitchensStateCopyWith<$Res> implements $CreateFoodKitchensStateCopyWith<$Res> {
  factory _$CreateFoodKitchensStateCopyWith(_CreateFoodKitchensState value, $Res Function(_CreateFoodKitchensState) _then) = __$CreateFoodKitchensStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<KitchenModel> kitchens, int activeIndex, TextEditingController? kitchenController
});




}
/// @nodoc
class __$CreateFoodKitchensStateCopyWithImpl<$Res>
    implements _$CreateFoodKitchensStateCopyWith<$Res> {
  __$CreateFoodKitchensStateCopyWithImpl(this._self, this._then);

  final _CreateFoodKitchensState _self;
  final $Res Function(_CreateFoodKitchensState) _then;

/// Create a copy of CreateFoodKitchensState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? kitchens = null,Object? activeIndex = null,Object? kitchenController = freezed,}) {
  return _then(_CreateFoodKitchensState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,kitchens: null == kitchens ? _self._kitchens : kitchens // ignore: cast_nullable_to_non_nullable
as List<KitchenModel>,activeIndex: null == activeIndex ? _self.activeIndex : activeIndex // ignore: cast_nullable_to_non_nullable
as int,kitchenController: freezed == kitchenController ? _self.kitchenController : kitchenController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}


}

// dart format on
