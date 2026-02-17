import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodsFilterItem extends StatelessWidget {
  final String title;
  final List list;
  final bool isRating;
  final bool isPrice;
  final bool isOffer;
  final bool isSort;
  final String? currentItem;
  final String? currentItemTwo;
  final ValueChanged<String> onTap;

  const FoodsFilterItem({
    super.key,
    required this.title,
    required this.list,
    required this.onTap,
    this.isRating = false,
    this.isOffer = false,
    this.isSort = false,
    this.currentItem = '',
    this.currentItemTwo = '',
    this.isPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.only(left: 18, right: 18, top: 18, bottom: 10),
      decoration: BoxDecoration(
        color: AppStyle.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.interSemi(size: 16, color: AppStyle.blackColor),
          ),
          18.verticalSpace,
          Wrap(
            children: list
                .map(
                  (e) => GestureDetector(
                    onTap: () => onTap(e),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: REdgeInsets.only(right: 8, bottom: 8),
                      padding: REdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: currentItem == e || currentItemTwo == e
                            ? AppStyle.primary
                            : AppStyle.greyColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          isRating
                              ? Row(
                                  children: [
                                    Icon(
                                      FlutterRemix.star_smile_fill,
                                      size: 16.r,
                                    ),
                                    6.horizontalSpace,
                                  ],
                                )
                              : isOffer
                              ? Row(
                                  children: [
                                    Icon(FlutterRemix.leaf_fill, size: 16.r),
                                    6.horizontalSpace,
                                  ],
                                )
                              : isSort
                              ? Row(
                                  children: [
                                    Container(
                                      width: 14.w,
                                      height: 14.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: currentItem == e ? 4.r : 2.r,
                                          color: AppStyle.blackColor,
                                        ),
                                        color: AppStyle.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    6.horizontalSpace,
                                  ],
                                )
                              : const SizedBox.shrink(),
                          isPrice
                              ? Text(
                                  AppHelpers.numberFormat(double.tryParse(e)),
                                  style: AppStyle.interNormal(
                                    size: 14,
                                    color: AppStyle.blackColor,
                                  ),
                                )
                              : Text(
                                  e,
                                  style: AppStyle.interNormal(
                                    size: 14,
                                    color: AppStyle.blackColor,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
