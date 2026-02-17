import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class DeliveryTypeItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String desc;
  final bool isActive;
  final VoidCallback onTap;

  const DeliveryTypeItem({
    super.key,
    required this.iconData,
    required this.title,
    required this.desc,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsBouncingEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isActive ? AppStyle.primary : AppStyle.shimmerBase,
            ),
          ),
          padding: REdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? AppStyle.blackColor : AppStyle.transparent,
                  border: Border.all(color: AppStyle.blackColor),
                ),
                padding: EdgeInsets.all(10.r),
                child: Center(
                  child: Icon(
                    iconData,
                    color: isActive ? AppStyle.primary : AppStyle.blackColor,
                  ),
                ),
              ),
              10.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppStyle.interSemi(
                      size: 14,
                      color: AppStyle.blackColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    desc,
                    style: AppStyle.interNormal(
                      size: 12,
                      color: AppStyle.blackColor,
                      letterSpacing: -0.3,
                    ),
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
