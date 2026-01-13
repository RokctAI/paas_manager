import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../../component/components.dart';
import '../../../../../../../infrastructure/models/models.dart';

class SectionItem extends StatelessWidget {
  final ShopSection? section;
  final bool isSelected;
  final Function() onTap;

  const SectionItem({
    super.key,
    required this.section,
    required this.onTap,
    required this.isSelected,
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 74.r,
        margin: REdgeInsets.only(bottom: 8),
        padding: REdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color:
              isSelected ? Style.primary.withOpacity(0.06) : Style.white,
          borderRadius: isSelected ? null : BorderRadius.circular(10.r),
          border: isSelected
              ? Border(
                  left: BorderSide(color: Style.primary, width: 1.r),
                )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 50.r,
              height: 50.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Style.black.withOpacity(0.06),
              ),
              alignment: Alignment.center,
              child: CommonImage(
                url: section?.img,
                width: 40,
                height: 40,
                radius: 20,
                errorRadius: 20,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    section?.translation?.title ?? "",
                    style: Style.interSemi(size: 15.sp),
                  ),
                  4.verticalSpace,
                  Text(
                    section?.area ?? "",
                    style: Style.interNormal(size: 12.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
