// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

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

  const LogoutModal({super.key, this.isDeleteAccount = false}) ;

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
              AppHelpers.getTranslation(isDeleteAccount
                  ? TrKeys.areYouSure
                  : TrKeys.doYouReallyWantToLogout),
              style: Style.interSemi(size: 16.sp),
              textAlign: TextAlign.center,
            ),
            40.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                      borderColor: Style.black,
                      background: Style.transparent,
                      title: AppHelpers.getTranslation(TrKeys.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Consumer(builder: (context, ref, child) {
                    if (isDeleteAccount) {
                      return CustomButton(
                          background: Style.red,
                          textColor: Style.white,
                          title: AppHelpers.getTranslation(TrKeys.deleteAccount),
                          onPressed: () {
                            ref
                                .read(profileProvider.notifier)
                                .deleteAccount(context);
                          });
                    } else {
                      return CustomButton(
                          title: AppHelpers.getTranslation(TrKeys.logout),
                          onPressed: () {
                            LocalStorage.logout();
                            context.router.popUntilRoot();
                            context.replaceRoute(const LoginRoute());
                          });
                    }
                  }),
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
