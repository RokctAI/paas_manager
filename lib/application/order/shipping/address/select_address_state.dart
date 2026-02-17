import 'package:flutter/material.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:venderfoodyman/infrastructure/models/models.dart';

part 'select_address_state.freezed.dart';

@freezed
abstract class SelectAddressState with _$SelectAddressState {
  const factory SelectAddressState({
    @Default(false) bool isSearching,
    @Default(false) bool isSearchLoading,
    @Default(false) bool isChoosing,
    @Default([]) List<Place> searchedPlaces,
    TextEditingController? textController,
    GoogleMapController? mapController,
    LocationData? location,
  }) = _SelectAddressState;

  const SelectAddressState._();
}
