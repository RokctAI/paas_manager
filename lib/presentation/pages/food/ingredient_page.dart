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
import '../../component/components.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class IngredientPage extends StatelessWidget {
  const IngredientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.size)),
          24.verticalSpace,
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Small",
                        style: Style.interRegular(
                            size: 14.sp, color: Style.blackColor),
                      ),
                      Text(
                        "\$64",
                        style: Style.interRegular(
                            size: 14.sp, color: Style.blackColor),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  const Divider(color: Style.shimmerBase)
                ],
              );
            },
          ),
          TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.ingredients)),
          24.verticalSpace,
          ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Double cheese",
                        style: Style.interRegular(
                            size: 14.sp, color: Style.blackColor),
                      ),
                      Text(
                        "\$76",
                        style: Style.interRegular(
                            size: 14.sp, color: Style.blackColor),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  const Divider(color: Style.shimmerBase)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
