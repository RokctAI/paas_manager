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

class TableModel {
  final String name;
  final int chairCount;
  final int tax;
  final int shopSectionId;

  TableModel({
    required this.name,
    required this.chairCount,
    required this.tax,
    required this.shopSectionId,
  });

  toJson() => {
        "name": name,
        "chair_count": chairCount,
        "tax": tax,
        "shop_section_id": shopSectionId
      };
}
