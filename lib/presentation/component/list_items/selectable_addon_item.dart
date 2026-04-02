import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class SelectableAddonItem extends StatelessWidget {
  final ProductData addon;
  final bool isLast;
  final VoidCallback? onTap;

  const SelectableAddonItem({
    super.key,
    required this.addon,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          18.verticalSpace,
          Row(
            children: [
              Icon(
                (addon.isSelectedAddon ?? false)
                    ? FlutterRemix.checkbox_circle_fill
                    : FlutterRemix.checkbox_blank_circle_line,
                size: 24.r,
                color: (addon.isSelectedAddon ?? false)
                    ? AppStyle.primary
                    : AppStyle.blackColor,
              ),
              14.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${addon.translation?.title}',
                      style: AppStyle.interSemi(size: 14, letterSpacing: -0.3),
                    ),
                    4.verticalSpace,
                    Text(
                      '${addon.translation?.description}',
                      style: AppStyle.interRegular(
                        size: 12,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.verticalSpace,
          if (!isLast)
            Divider(
              thickness: 1.r,
              height: 1.r,
              color: AppStyle.textColor.withOpacity(0.15),
            ),
        ],
      ),
    );
  }
}
