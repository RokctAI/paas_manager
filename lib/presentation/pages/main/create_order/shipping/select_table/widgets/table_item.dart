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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../../../infrastructure/models/models.dart';

class TableItem extends StatelessWidget {
  final TableData? table;
  final bool isSelected;
  final Function() onTap;

  const TableItem({
    super.key,
    required this.table,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 74.r,
        margin: REdgeInsets.only(bottom: 8),
        padding: REdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Style.primary.withOpacity(0.06) : Style.white,
          borderRadius: isSelected ? null : BorderRadius.circular(10.r),
          border: isSelected
              ? Border(
                  left: BorderSide(color: Style.primary, width: 1.r),
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                table?.name ?? "",
                style: Style.interSemi(size: 15.sp),
              ),
            ),
            4.verticalSpace,
            Row(
              children: [
                Icon(
                  Icons.chair_alt,
                  size: 21.r,
                ),
                Text(
                  "${table?.chairCount ?? 0}",
                  style: Style.interNormal(size: 12.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
