import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class MainGroupItem extends StatelessWidget {
  final Group group;
  final Function() onTap;

  const MainGroupItem({super.key, required this.group, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ButtonsBouncingEffect(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppStyle.white,
          ),
          padding: REdgeInsets.all(18),
          margin: REdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${group.translation?.title}',
                style: AppStyle.interNormal(),
              ),
              Icon(
                FlutterRemix.arrow_right_s_line,
                size: 22.r,
                color: AppStyle.blackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
