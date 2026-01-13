import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/data/location_data.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';

import 'package:venderfoodyman/infrastructure/models/data/address_data.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import '../component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppHelpers.getTranslation(TrKeys.agreeLocation),
          style: Style.interSemi(size: 16.sp),
          textAlign: TextAlign.center,
        ),
        24.verticalSpace,
        Row(
          children: [
            Expanded(
              child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.cancel),
                  borderColor: Style.black,
                  background: Style.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                    context.pushRoute(ViewMapRoute(onChanged: () {}));
                  }),
            ),
            24.horizontalSpace,
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                return CustomButton(
                    title: AppHelpers.getTranslation(TrKeys.yes),
                    onPressed: () {
                      Navigator.pop(context);
                      LocalStorage.setAddressSelected(
                        AddressData(
                            location: LocationData(
                              latitude: (AppHelpers.getInitialLatitude() ??
                                  AppConstants.demoLatitude),
                              longitude: (AppHelpers.getInitialLongitude() ??
                                  AppConstants.demoLongitude),
                            ),
                            title: AppHelpers.getAppAddressName()),
                      );
                      //ref.read(homeProvider.notifier).setAddress();
                    });
              }),
            ),
          ],
        )
      ],
    );
  }
}
