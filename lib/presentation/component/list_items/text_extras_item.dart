import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';

class TextExtrasItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  final String title;
  final bool isLast;

  const TextExtrasItem({
    super.key,
    required this.onTap,
    required this.isActive,
    required this.title,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
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
                      color: isActive ? Style.green : Style.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? Style.blackColor : Style.greyColor,
                        width: isActive ? 4.r : 2.r,
                      ),
                    ),
                  ),
                  16.horizontalSpace,
                  Text(
                    title,
                    style: Style.interNormal(
                      size: 16.sp,
                      color: Style.blackColor,
                    ),
                  ),
                ],
              ),
              if (!isLast)
                Column(
                  children: [
                    16.verticalSpace,
                    Divider(
                      color: Style.textColor.withOpacity(0.1),
                      height: 1.r,
                      thickness: 1.r,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
