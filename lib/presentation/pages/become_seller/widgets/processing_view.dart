import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/pages/restaurant/widgets/logout_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class ProcessingView extends StatelessWidget {
  const ProcessingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: AppStyle.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppStyle.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200.h,
                  child: Lottie.asset('assets/lottie/processing.json'),
                ),
                16.verticalSpace,
                Text(
                  AppHelpers.getTranslation(TrKeys.yourRequest),
                  style: AppStyle.interSemi(size: 18, color: AppStyle.black),
                  textAlign: TextAlign.center,
                ),
                12.verticalSpace,
                Text(
                  'We are reviewing your application. You will be notified once approved.',
                  style: AppStyle.interRegular(
                    size: 14,
                    color: AppStyle.textGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () => AppHelpers.showCustomModalBottomSheet(
              context: context,
              modal: const LogoutModal(),
              isDarkMode: false,
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              side: BorderSide(
                color: AppStyle.red.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: Text(
              AppHelpers.getTranslation(TrKeys.logout),
              style: AppStyle.interSemi(size: 15, color: AppStyle.red),
            ),
          ),
          36.verticalSpace,
        ],
      ),
    );
  }
}
