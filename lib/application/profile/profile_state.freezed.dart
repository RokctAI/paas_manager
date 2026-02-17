// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {

 bool get isLoading; bool get isReferralLoading; bool get isSaveLoading; bool get isLoadingHistory; int get typeIndex; String get bgImage; String get logoImage; AddressData? get addressModel; UserData? get userData; ReferralModel? get referralData; List<WalletData>? get walletHistory; List<String> get filepath;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isReferralLoading, isReferralLoading) || other.isReferralLoading == isReferralLoading)&&(identical(other.isSaveLoading, isSaveLoading) || other.isSaveLoading == isSaveLoading)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.typeIndex, typeIndex) || other.typeIndex == typeIndex)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage)&&(identical(other.logoImage, logoImage) || other.logoImage == logoImage)&&(identical(other.addressModel, addressModel) || other.addressModel == addressModel)&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.referralData, referralData) || other.referralData == referralData)&&const DeepCollectionEquality().equals(other.walletHistory, walletHistory)&&const DeepCollectionEquality().equals(other.filepath, filepath));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isReferralLoading,isSaveLoading,isLoadingHistory,typeIndex,bgImage,logoImage,addressModel,userData,referralData,const DeepCollectionEquality().hash(walletHistory),const DeepCollectionEquality().hash(filepath));

@override
String toString() {
  return 'ProfileState(isLoading: $isLoading, isReferralLoading: $isReferralLoading, isSaveLoading: $isSaveLoading, isLoadingHistory: $isLoadingHistory, typeIndex: $typeIndex, bgImage: $bgImage, logoImage: $logoImage, addressModel: $addressModel, userData: $userData, referralData: $referralData, walletHistory: $walletHistory, filepath: $filepath)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isReferralLoading, bool isSaveLoading, bool isLoadingHistory, int typeIndex, String bgImage, String logoImage, AddressData? addressModel, UserData? userData, ReferralModel? referralData, List<WalletData>? walletHistory, List<String> filepath
});




}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isReferralLoading = null,Object? isSaveLoading = null,Object? isLoadingHistory = null,Object? typeIndex = null,Object? bgImage = null,Object? logoImage = null,Object? addressModel = freezed,Object? userData = freezed,Object? referralData = freezed,Object? walletHistory = freezed,Object? filepath = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isReferralLoading: null == isReferralLoading ? _self.isReferralLoading : isReferralLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaveLoading: null == isSaveLoading ? _self.isSaveLoading : isSaveLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,typeIndex: null == typeIndex ? _self.typeIndex : typeIndex // ignore: cast_nullable_to_non_nullable
as int,bgImage: null == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String,logoImage: null == logoImage ? _self.logoImage : logoImage // ignore: cast_nullable_to_non_nullable
as String,addressModel: freezed == addressModel ? _self.addressModel : addressModel // ignore: cast_nullable_to_non_nullable
as AddressData?,userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as UserData?,referralData: freezed == referralData ? _self.referralData : referralData // ignore: cast_nullable_to_non_nullable
as ReferralModel?,walletHistory: freezed == walletHistory ? _self.walletHistory : walletHistory // ignore: cast_nullable_to_non_nullable
as List<WalletData>?,filepath: null == filepath ? _self.filepath : filepath // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isReferralLoading,  bool isSaveLoading,  bool isLoadingHistory,  int typeIndex,  String bgImage,  String logoImage,  AddressData? addressModel,  UserData? userData,  ReferralModel? referralData,  List<WalletData>? walletHistory,  List<String> filepath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.isLoading,_that.isReferralLoading,_that.isSaveLoading,_that.isLoadingHistory,_that.typeIndex,_that.bgImage,_that.logoImage,_that.addressModel,_that.userData,_that.referralData,_that.walletHistory,_that.filepath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isReferralLoading,  bool isSaveLoading,  bool isLoadingHistory,  int typeIndex,  String bgImage,  String logoImage,  AddressData? addressModel,  UserData? userData,  ReferralModel? referralData,  List<WalletData>? walletHistory,  List<String> filepath)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.isLoading,_that.isReferralLoading,_that.isSaveLoading,_that.isLoadingHistory,_that.typeIndex,_that.bgImage,_that.logoImage,_that.addressModel,_that.userData,_that.referralData,_that.walletHistory,_that.filepath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isReferralLoading,  bool isSaveLoading,  bool isLoadingHistory,  int typeIndex,  String bgImage,  String logoImage,  AddressData? addressModel,  UserData? userData,  ReferralModel? referralData,  List<WalletData>? walletHistory,  List<String> filepath)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.isLoading,_that.isReferralLoading,_that.isSaveLoading,_that.isLoadingHistory,_that.typeIndex,_that.bgImage,_that.logoImage,_that.addressModel,_that.userData,_that.referralData,_that.walletHistory,_that.filepath);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState extends ProfileState {
  const _ProfileState({this.isLoading = true, this.isReferralLoading = true, this.isSaveLoading = false, this.isLoadingHistory = true, this.typeIndex = 0, this.bgImage = "", this.logoImage = "", this.addressModel = null, this.userData = null, this.referralData = null, final  List<WalletData>? walletHistory = const [], final  List<String> filepath = const []}): _walletHistory = walletHistory,_filepath = filepath,super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isReferralLoading;
@override@JsonKey() final  bool isSaveLoading;
@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  int typeIndex;
@override@JsonKey() final  String bgImage;
@override@JsonKey() final  String logoImage;
@override@JsonKey() final  AddressData? addressModel;
@override@JsonKey() final  UserData? userData;
@override@JsonKey() final  ReferralModel? referralData;
 final  List<WalletData>? _walletHistory;
@override@JsonKey() List<WalletData>? get walletHistory {
  final value = _walletHistory;
  if (value == null) return null;
  if (_walletHistory is EqualUnmodifiableListView) return _walletHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String> _filepath;
@override@JsonKey() List<String> get filepath {
  if (_filepath is EqualUnmodifiableListView) return _filepath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filepath);
}


/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isReferralLoading, isReferralLoading) || other.isReferralLoading == isReferralLoading)&&(identical(other.isSaveLoading, isSaveLoading) || other.isSaveLoading == isSaveLoading)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.typeIndex, typeIndex) || other.typeIndex == typeIndex)&&(identical(other.bgImage, bgImage) || other.bgImage == bgImage)&&(identical(other.logoImage, logoImage) || other.logoImage == logoImage)&&(identical(other.addressModel, addressModel) || other.addressModel == addressModel)&&(identical(other.userData, userData) || other.userData == userData)&&(identical(other.referralData, referralData) || other.referralData == referralData)&&const DeepCollectionEquality().equals(other._walletHistory, _walletHistory)&&const DeepCollectionEquality().equals(other._filepath, _filepath));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isReferralLoading,isSaveLoading,isLoadingHistory,typeIndex,bgImage,logoImage,addressModel,userData,referralData,const DeepCollectionEquality().hash(_walletHistory),const DeepCollectionEquality().hash(_filepath));

@override
String toString() {
  return 'ProfileState(isLoading: $isLoading, isReferralLoading: $isReferralLoading, isSaveLoading: $isSaveLoading, isLoadingHistory: $isLoadingHistory, typeIndex: $typeIndex, bgImage: $bgImage, logoImage: $logoImage, addressModel: $addressModel, userData: $userData, referralData: $referralData, walletHistory: $walletHistory, filepath: $filepath)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isReferralLoading, bool isSaveLoading, bool isLoadingHistory, int typeIndex, String bgImage, String logoImage, AddressData? addressModel, UserData? userData, ReferralModel? referralData, List<WalletData>? walletHistory, List<String> filepath
});




}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isReferralLoading = null,Object? isSaveLoading = null,Object? isLoadingHistory = null,Object? typeIndex = null,Object? bgImage = null,Object? logoImage = null,Object? addressModel = freezed,Object? userData = freezed,Object? referralData = freezed,Object? walletHistory = freezed,Object? filepath = null,}) {
  return _then(_ProfileState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isReferralLoading: null == isReferralLoading ? _self.isReferralLoading : isReferralLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaveLoading: null == isSaveLoading ? _self.isSaveLoading : isSaveLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,typeIndex: null == typeIndex ? _self.typeIndex : typeIndex // ignore: cast_nullable_to_non_nullable
as int,bgImage: null == bgImage ? _self.bgImage : bgImage // ignore: cast_nullable_to_non_nullable
as String,logoImage: null == logoImage ? _self.logoImage : logoImage // ignore: cast_nullable_to_non_nullable
as String,addressModel: freezed == addressModel ? _self.addressModel : addressModel // ignore: cast_nullable_to_non_nullable
as AddressData?,userData: freezed == userData ? _self.userData : userData // ignore: cast_nullable_to_non_nullable
as UserData?,referralData: freezed == referralData ? _self.referralData : referralData // ignore: cast_nullable_to_non_nullable
as ReferralModel?,walletHistory: freezed == walletHistory ? _self._walletHistory : walletHistory // ignore: cast_nullable_to_non_nullable
as List<WalletData>?,filepath: null == filepath ? _self._filepath : filepath // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
