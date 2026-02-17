import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/data/address_data.dart';
import 'package:venderfoodyman/infrastructure/models/data/referral_data.dart';
import 'package:venderfoodyman/infrastructure/models/data/user_data.dart';
import 'package:venderfoodyman/infrastructure/models/response/wallet_histories_response.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(true) bool isLoading,
    @Default(true) bool isReferralLoading,
    @Default(false) bool isSaveLoading,
    @Default(true) bool isLoadingHistory,
    @Default(0) int typeIndex,
    @Default("") String bgImage,
    @Default("") String logoImage,
    @Default(null) AddressData? addressModel,
    @Default(null) UserData? userData,
    @Default(null) ReferralModel? referralData,
    @Default([]) List<WalletData>? walletHistory,
    @Default([]) List<String> filepath,
  }) = _ProfileState;

  const ProfileState._();
}
