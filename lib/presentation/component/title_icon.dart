import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class TitleAndIcon extends StatelessWidget {
  final String title;
  final double titleSize;
  final String? rightTitle;
  final bool isIcon;
  final Color rightTitleColor;
  final VoidCallback? onRightTap;

  const TitleAndIcon({
    super.key,
    this.isIcon = false,
    required this.title,
    this.rightTitle,
    this.rightTitleColor = Style.blackColor,
    this.onRightTap,
    this.titleSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: Style.interSemi(size: 18.sp, color: Style.blackColor),
            ),
          ),
          GestureDetector(
            onTap: onRightTap ?? () {},
            child: Row(
              children: [
                Text(
                  rightTitle ?? '',
                  style: Style.interRegular(
                    size: 14.sp,
                    color: rightTitleColor,
                  ),
                ),
                isIcon
                    ? Icon(
                        isLtr
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_left,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
