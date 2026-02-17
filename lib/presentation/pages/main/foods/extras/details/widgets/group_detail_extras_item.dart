import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../../component/components.dart';
import '../../../../../../../infrastructure/models/models.dart';

class GroupDetailExtrasItem extends StatelessWidget {
  final Extras extras;
  final Function() onEditTap;
  final Function() onDeleteTap;

  const GroupDetailExtrasItem({
    super.key,
    required this.extras,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: REdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              extras.value ?? '',
              style: AppStyle.interRegular(
                size: 15,
                color: AppStyle.blackColor,
                letterSpacing: -0.3,
              ),
            ),
            if (extras.group?.shopId == LocalStorage.getShop()?.id)
              Row(
                children: [
                  ButtonsBouncingEffect(
                    child: GestureDetector(
                      onTap: onEditTap,
                      child: Icon(
                        FlutterRemix.pencil_fill,
                        size: 20.r,
                        color: AppStyle.blackColor,
                      ),
                    ),
                  ),
                  20.horizontalSpace,
                  ButtonsBouncingEffect(
                    child: GestureDetector(
                      onTap: onDeleteTap,
                      child: Icon(
                        FlutterRemix.delete_bin_line,
                        size: 20.r,
                        color: AppStyle.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
