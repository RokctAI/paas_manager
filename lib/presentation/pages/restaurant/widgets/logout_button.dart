import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logout_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class LogoutButton extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onChange;

  const LogoutButton({super.key, required this.isOpen, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 6.r,
      right: 16.r,
      child: Row(
        children: [
          BlurWrap(
            radius: BorderRadius.circular(10.r),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppStyle.blackColor.withOpacity(0.29),
              ),
              padding: EdgeInsets.all(4.r),
              child: CustomToggle(
                isText: true,
                key: UniqueKey(),
                controller: ValueNotifier<bool>(isOpen),
                onChange: (value) {
                  onChange();
                },
              ),
            ),
          ),
          16.horizontalSpace,
          ButtonsBouncingEffect(
            child: GestureDetector(
              onTap: () => AppHelpers.showCustomModalBottomSheet(
                context: context,
                modal: const LogoutModal(),
                isDarkMode: LocalStorage.getAppThemeMode(),
              ),
              child: BlurWrap(
                radius: BorderRadius.circular(10.r),
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppStyle.blackColor.withOpacity(0.29),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    FlutterRemix.logout_circle_r_line,
                    color: AppStyle.white,
                    size: 22.r,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
