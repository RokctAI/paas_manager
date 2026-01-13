
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/models/data/address_data.dart';

part 'view_map_state.freezed.dart';

@freezed
class ViewMapState with _$ViewMapState {
  const factory ViewMapState({
    @Default(false) bool isLoading,
    @Default(false) bool isActive,
    @Default(null) AddressData? place,
    @Default(false) bool isSetAddress,
  }) = _ViewMapState;

  const ViewMapState._();
}
