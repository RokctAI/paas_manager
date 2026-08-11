// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:manager/infrastructure/models/data/address_data.dart';
import 'package:manager/infrastructure/services/services.dart';
import 'package:manager/presentation/pages/add_address.dart';
import 'view_map_state.dart';

class ViewMapNotifier extends StateNotifier<ViewMapState> {
  ViewMapNotifier() : super(const ViewMapState());

  void changePlace(AddressData place) {
    state = state.copyWith(place: place, isSetAddress: true);
  }

  void checkAddress(BuildContext context) {
    AddressData? data = LocalStorage.getAddressSelected();
    if (data == null) {
      state = state.copyWith(isSetAddress: false);
      AppHelpers.showAlertDialog(context: context, child: const AddAddress());
    } else {
      state = state.copyWith(isSetAddress: true);
    }
  }

  updateActive() {
    state = state.copyWith(isLoading: true);
  }
}
