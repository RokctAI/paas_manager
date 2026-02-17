// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_translation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiTranslationState {

 bool get isLoading; bool get translatedUsingAi; LanguageData? get selectedLanguage;
/// Create a copy of AiTranslationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiTranslationStateCopyWith<AiTranslationState> get copyWith => _$AiTranslationStateCopyWithImpl<AiTranslationState>(this as AiTranslationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiTranslationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.translatedUsingAi, translatedUsingAi) || other.translatedUsingAi == translatedUsingAi)&&(identical(other.selectedLanguage, selectedLanguage) || other.selectedLanguage == selectedLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,translatedUsingAi,selectedLanguage);

@override
String toString() {
  return 'AiTranslationState(isLoading: $isLoading, translatedUsingAi: $translatedUsingAi, selectedLanguage: $selectedLanguage)';
}


}

/// @nodoc
abstract mixin class $AiTranslationStateCopyWith<$Res>  {
  factory $AiTranslationStateCopyWith(AiTranslationState value, $Res Function(AiTranslationState) _then) = _$AiTranslationStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool translatedUsingAi, LanguageData? selectedLanguage
});




}
/// @nodoc
class _$AiTranslationStateCopyWithImpl<$Res>
    implements $AiTranslationStateCopyWith<$Res> {
  _$AiTranslationStateCopyWithImpl(this._self, this._then);

  final AiTranslationState _self;
  final $Res Function(AiTranslationState) _then;

/// Create a copy of AiTranslationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? translatedUsingAi = null,Object? selectedLanguage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,translatedUsingAi: null == translatedUsingAi ? _self.translatedUsingAi : translatedUsingAi // ignore: cast_nullable_to_non_nullable
as bool,selectedLanguage: freezed == selectedLanguage ? _self.selectedLanguage : selectedLanguage // ignore: cast_nullable_to_non_nullable
as LanguageData?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiTranslationState].
extension AiTranslationStatePatterns on AiTranslationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiTranslationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiTranslationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiTranslationState value)  $default,){
final _that = this;
switch (_that) {
case _AiTranslationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiTranslationState value)?  $default,){
final _that = this;
switch (_that) {
case _AiTranslationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool translatedUsingAi,  LanguageData? selectedLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiTranslationState() when $default != null:
return $default(_that.isLoading,_that.translatedUsingAi,_that.selectedLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool translatedUsingAi,  LanguageData? selectedLanguage)  $default,) {final _that = this;
switch (_that) {
case _AiTranslationState():
return $default(_that.isLoading,_that.translatedUsingAi,_that.selectedLanguage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool translatedUsingAi,  LanguageData? selectedLanguage)?  $default,) {final _that = this;
switch (_that) {
case _AiTranslationState() when $default != null:
return $default(_that.isLoading,_that.translatedUsingAi,_that.selectedLanguage);case _:
  return null;

}
}

}

/// @nodoc


class _AiTranslationState extends AiTranslationState {
  const _AiTranslationState({this.isLoading = false, this.translatedUsingAi = false, this.selectedLanguage}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool translatedUsingAi;
@override final  LanguageData? selectedLanguage;

/// Create a copy of AiTranslationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiTranslationStateCopyWith<_AiTranslationState> get copyWith => __$AiTranslationStateCopyWithImpl<_AiTranslationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiTranslationState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.translatedUsingAi, translatedUsingAi) || other.translatedUsingAi == translatedUsingAi)&&(identical(other.selectedLanguage, selectedLanguage) || other.selectedLanguage == selectedLanguage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,translatedUsingAi,selectedLanguage);

@override
String toString() {
  return 'AiTranslationState(isLoading: $isLoading, translatedUsingAi: $translatedUsingAi, selectedLanguage: $selectedLanguage)';
}


}

/// @nodoc
abstract mixin class _$AiTranslationStateCopyWith<$Res> implements $AiTranslationStateCopyWith<$Res> {
  factory _$AiTranslationStateCopyWith(_AiTranslationState value, $Res Function(_AiTranslationState) _then) = __$AiTranslationStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool translatedUsingAi, LanguageData? selectedLanguage
});




}
/// @nodoc
class __$AiTranslationStateCopyWithImpl<$Res>
    implements _$AiTranslationStateCopyWith<$Res> {
  __$AiTranslationStateCopyWithImpl(this._self, this._then);

  final _AiTranslationState _self;
  final $Res Function(_AiTranslationState) _then;

/// Create a copy of AiTranslationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? translatedUsingAi = null,Object? selectedLanguage = freezed,}) {
  return _then(_AiTranslationState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,translatedUsingAi: null == translatedUsingAi ? _self.translatedUsingAi : translatedUsingAi // ignore: cast_nullable_to_non_nullable
as bool,selectedLanguage: freezed == selectedLanguage ? _self.selectedLanguage : selectedLanguage // ignore: cast_nullable_to_non_nullable
as LanguageData?,
  ));
}


}

// dart format on
