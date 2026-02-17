import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';

class Loading extends StatelessWidget {
  final int width;

  const Loading({super.key, this.width = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ? SizedBox(
              height: width.r,
              width: width.r,
              child: CircularProgressIndicator(
                color: AppStyle.blackColor,
                strokeWidth: 3.r,
              ),
            )
          : const CupertinoActivityIndicator(radius: 12),
    );
  }
}
