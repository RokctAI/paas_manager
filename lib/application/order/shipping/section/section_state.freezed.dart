// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SectionState {

 List<ShopSection> get sections; int get selectedIndex; bool get isLoading; ShopSection? get selectSection; TextEditingController? get textController;
/// Create a copy of SectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionStateCopyWith<SectionState> get copyWith => _$SectionStateCopyWithImpl<SectionState>(this as SectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionState&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectSection, selectSection) || other.selectSection == selectSection)&&(identical(other.textController, textController) || other.textController == textController));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sections),selectedIndex,isLoading,selectSection,textController);

@override
String toString() {
  return 'SectionState(sections: $sections, selectedIndex: $selectedIndex, isLoading: $isLoading, selectSection: $selectSection, textController: $textController)';
}


}

/// @nodoc
abstract mixin class $SectionStateCopyWith<$Res>  {
  factory $SectionStateCopyWith(SectionState value, $Res Function(SectionState) _then) = _$SectionStateCopyWithImpl;
@useResult
$Res call({
 List<ShopSection> sections, int selectedIndex, bool isLoading, ShopSection? selectSection, TextEditingController? textController
});




}
/// @nodoc
class _$SectionStateCopyWithImpl<$Res>
    implements $SectionStateCopyWith<$Res> {
  _$SectionStateCopyWithImpl(this._self, this._then);

  final SectionState _self;
  final $Res Function(SectionState) _then;

/// Create a copy of SectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sections = null,Object? selectedIndex = null,Object? isLoading = null,Object? selectSection = freezed,Object? textController = freezed,}) {
  return _then(_self.copyWith(
sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<ShopSection>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectSection: freezed == selectSection ? _self.selectSection : selectSection // ignore: cast_nullable_to_non_nullable
as ShopSection?,textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}

}


/// Adds pattern-matching-related methods to [SectionState].
extension SectionStatePatterns on SectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SectionState value)  $default,){
final _that = this;
switch (_that) {
case _SectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SectionState value)?  $default,){
final _that = this;
switch (_that) {
case _SectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ShopSection> sections,  int selectedIndex,  bool isLoading,  ShopSection? selectSection,  TextEditingController? textController)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SectionState() when $default != null:
return $default(_that.sections,_that.selectedIndex,_that.isLoading,_that.selectSection,_that.textController);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ShopSection> sections,  int selectedIndex,  bool isLoading,  ShopSection? selectSection,  TextEditingController? textController)  $default,) {final _that = this;
switch (_that) {
case _SectionState():
return $default(_that.sections,_that.selectedIndex,_that.isLoading,_that.selectSection,_that.textController);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ShopSection> sections,  int selectedIndex,  bool isLoading,  ShopSection? selectSection,  TextEditingController? textController)?  $default,) {final _that = this;
switch (_that) {
case _SectionState() when $default != null:
return $default(_that.sections,_that.selectedIndex,_that.isLoading,_that.selectSection,_that.textController);case _:
  return null;

}
}

}

/// @nodoc


class _SectionState extends SectionState {
  const _SectionState({final  List<ShopSection> sections = const [], this.selectedIndex = 0, this.isLoading = false, this.selectSection, this.textController}): _sections = sections,super._();
  

 final  List<ShopSection> _sections;
@override@JsonKey() List<ShopSection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override@JsonKey() final  int selectedIndex;
@override@JsonKey() final  bool isLoading;
@override final  ShopSection? selectSection;
@override final  TextEditingController? textController;

/// Create a copy of SectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SectionStateCopyWith<_SectionState> get copyWith => __$SectionStateCopyWithImpl<_SectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SectionState&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.selectSection, selectSection) || other.selectSection == selectSection)&&(identical(other.textController, textController) || other.textController == textController));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sections),selectedIndex,isLoading,selectSection,textController);

@override
String toString() {
  return 'SectionState(sections: $sections, selectedIndex: $selectedIndex, isLoading: $isLoading, selectSection: $selectSection, textController: $textController)';
}


}

/// @nodoc
abstract mixin class _$SectionStateCopyWith<$Res> implements $SectionStateCopyWith<$Res> {
  factory _$SectionStateCopyWith(_SectionState value, $Res Function(_SectionState) _then) = __$SectionStateCopyWithImpl;
@override @useResult
$Res call({
 List<ShopSection> sections, int selectedIndex, bool isLoading, ShopSection? selectSection, TextEditingController? textController
});




}
/// @nodoc
class __$SectionStateCopyWithImpl<$Res>
    implements _$SectionStateCopyWith<$Res> {
  __$SectionStateCopyWithImpl(this._self, this._then);

  final _SectionState _self;
  final $Res Function(_SectionState) _then;

/// Create a copy of SectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sections = null,Object? selectedIndex = null,Object? isLoading = null,Object? selectSection = freezed,Object? textController = freezed,}) {
  return _then(_SectionState(
sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<ShopSection>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,selectSection: freezed == selectSection ? _self.selectSection : selectSection // ignore: cast_nullable_to_non_nullable
as ShopSection?,textController: freezed == textController ? _self.textController : textController // ignore: cast_nullable_to_non_nullable
as TextEditingController?,
  ));
}


}

// dart format on
