import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'view_map_state.freezed.dart';

@freezed
abstract class ViewMapState with _$ViewMapState {
  const factory ViewMapState({
    @Default(false) bool isLoading,
    @Default(false) bool isActive,
    @Default(null) AddressData? place,
    @Default(false) bool isSetAddress,
  }) = _ViewMapState;

  const ViewMapState._();
}
