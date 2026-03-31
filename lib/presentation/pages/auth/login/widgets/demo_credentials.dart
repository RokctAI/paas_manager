import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class DemoCredentials extends StatelessWidget {
  final VoidCallback onTap;

  const DemoCredentials({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            const Expanded(
              child: Divider(color: AppStyle.shimmerBase, height: 1),
            ),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 12),
              child: Text(
                AppHelpers.getTranslation(TrKeys.demoLoginPassword),
                style: AppStyle.interNormal(
                  size: 12,
                  color: AppStyle.textColor,
                ),
              ),
            ),
            const Expanded(
              child: Divider(color: AppStyle.shimmerBase, height: 1),
            ),
          ],
        ),
        24.verticalSpace,
        InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '${AppHelpers.getTranslation(TrKeys.login)}:',
                  style: AppStyle.interNormal(letterSpacing: -0.3),
                  children: [
                    TextSpan(
                      text: ' ${AppConstants.demoSellerLogin}',
                      style: AppStyle.interRegular(
                        letterSpacing: -0.3,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              6.verticalSpace,
              RichText(
                text: TextSpan(
                  text: '${AppHelpers.getTranslation(TrKeys.password)}:',
                  style: AppStyle.interNormal(letterSpacing: -0.3),
                  children: [
                    TextSpan(
                      text: ' ${AppConstants.demoSellerPassword}',
                      style: AppStyle.interRegular(
                        letterSpacing: -0.3,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              6.verticalSpace,
              RichText(
                text: TextSpan(
                  text: 'Base URL:',
                  style: AppStyle.interNormal(letterSpacing: -0.3),
                  children: [
                    TextSpan(
                      text: ' ${AppConstants.baseUrl}',
                      style: AppStyle.interRegular(
                        letterSpacing: -0.3,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        12.verticalSpace,
      ],
    );
  }
}
