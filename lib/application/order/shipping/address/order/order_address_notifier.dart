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

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_address_state.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class OrderAddressNotifier extends StateNotifier<OrderAddressState> {
  OrderAddressNotifier()
      : super(OrderAddressState(textController: TextEditingController()));

  void setHouse(String value) {
    state = state.copyWith(house: value.trim());
  }

  void setFloor(String value) {
    state = state.copyWith(floor: value.trim());
  }

  void setEntrance(String value) {
    state = state.copyWith(entrance: value.trim());
  }

  void setLocation({LocationData? location, required String title}) {
    state.textController?.text = title;
    state = state.copyWith(location: location);
  }
}
