import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../buttons/buttons_bouncing_effect.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class ExtrasItem extends StatelessWidget {
  final Group extras;
  final Function()? onTap;
  final bool isLast;

  const ExtrasItem({
    super.key,
    required this.extras,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsBouncingEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: AppStyle.transparent,
          padding: REdgeInsets.symmetric(vertical: 16),
          margin: REdgeInsets.only(right: 14),
          child: Row(
            children: [
              Icon(
                (extras.isChecked ?? false)
                    ? FlutterRemix.checkbox_circle_fill
                    : FlutterRemix.checkbox_blank_circle_line,
                color: (extras.isChecked ?? false)
                    ? AppStyle.primary
                    : AppStyle.blackColor,
                size: 24.r,
              ),
              4.horizontalSpace,
              Text(
                '${extras.translation?.title}',
                style: AppStyle.interSemi(size: 14, letterSpacing: -0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
