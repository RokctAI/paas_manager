import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'buttons_bouncing_effect.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class PopButton extends StatelessWidget {
  final String heroTag;

  const PopButton({super.key, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    return ButtonsBouncingEffect(
      child: Hero(
        tag: heroTag,
        child: GestureDetector(
          onTap: context.maybePop,
          child: Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: AppStyle.blackColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              isLtr
                  ? FlutterRemix.arrow_left_s_line
                  : FlutterRemix.arrow_right_s_line,
              color: AppStyle.white,
              size: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
