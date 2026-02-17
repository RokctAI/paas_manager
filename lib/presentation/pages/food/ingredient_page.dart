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
                        style: AppStyle.interRegular(
                          size: 14,
                          color: AppStyle.blackColor,
                        ),
                      ),
                      Text(
                        "\$64",
                        style: AppStyle.interRegular(
                          size: 14,
                          color: AppStyle.blackColor,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  const Divider(color: AppStyle.shimmerBase),
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
                        style: AppStyle.interRegular(
                          size: 14,
                          color: AppStyle.blackColor,
                        ),
                      ),
                      Text(
                        "\$76",
                        style: AppStyle.interRegular(
                          size: 14,
                          color: AppStyle.blackColor,
                        ),
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  const Divider(color: AppStyle.shimmerBase),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
