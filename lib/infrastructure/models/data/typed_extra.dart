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

import 'package:venderfoodyman/infrastructure/services/services.dart';

class UiExtra {
  final int index;
  final String value;
  final bool isSelected;

  UiExtra(this.value, this.isSelected, this.index);

  @override
  String toString() {
    return '(Extras name: $value is selected: $isSelected index: $index)';
  }
}

class TypedExtra {
  final int groupIndex;
  final ExtrasType type;
  final String title;
  final List<UiExtra> uiExtras;

  TypedExtra(this.type, this.uiExtras, this.title, this.groupIndex);

  @override
  String toString() {
    return '(Extras type: $type ui extras: $uiExtras title: $title group index: $groupIndex})';
  }
}
