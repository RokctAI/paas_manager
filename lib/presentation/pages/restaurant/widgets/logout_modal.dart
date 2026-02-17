import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/profile/profile_provider.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class LogoutModal extends StatelessWidget {
  final bool isDeleteAccount;

  const LogoutModal({super.key, this.isDeleteAccount = false});

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalDrag(),
            12.verticalSpace,
            Text(
              AppHelpers.getTranslation(
                isDeleteAccount
                    ? TrKeys.areYouSure
                    : TrKeys.doYouReallyWantToLogout,
              ),
              style: AppStyle.interSemi(size: 16),
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderColor: AppStyle.black,
                    background: AppStyle.transparent,
                    textColor: AppStyle.black,
                    title: AppHelpers.getTranslation(TrKeys.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      if (isDeleteAccount) {
                        return CustomButton(
                          background: AppStyle.red,
                          textColor: AppStyle.white,
                          title: AppHelpers.getTranslation(
                            TrKeys.deleteAccount,
                          ),
                          onPressed: () {
                            ref
                                .read(profileProvider.notifier)
                                .deleteAccount(context);
                          },
                        );
                      } else {
                        return CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.logout),
                          onPressed: () {
                            LocalStorage.logout();
                            context.router.popUntilRoot();
                            context.replaceRoute(const AuthRoute());
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}
