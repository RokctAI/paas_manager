import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/component/buttons/buttons_bouncing_effect.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class FoodCategoryItem extends StatelessWidget {
  final CategoryData category;
  final Function() onTap;
  final VoidCallback? onDelete;
  final bool isSelected;

  const FoodCategoryItem({
    super.key,
    required this.category,
    required this.onTap,
    required this.isSelected,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return category.status != "unpublished"
        ? Padding(
            padding: REdgeInsets.only(top: 8),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppStyle.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: REdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: 18.w,
                          height: 18.h,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppStyle.primary
                                : AppStyle.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppStyle.blackColor
                                  : AppStyle.textColor,
                              width: isSelected ? 4 : 2,
                            ),
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: Text(
                            category.translation?.title ?? "---",
                            style: AppStyle.interRegular(
                              size: 15,
                              color: AppStyle.blackColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        if (onDelete != null)
                          ButtonsBouncingEffect(
                            child: GestureDetector(
                              onTap: onDelete,
                              child: Icon(
                                FlutterRemix.delete_bin_line,
                                size: 21.r,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
