import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

class AddressSelector extends StatelessWidget {
  final AddressData? addressModel;
  final Function(dynamic) onAddressSelected;

  const AddressSelector({
    super.key,
    required this.addressModel,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    final hasAddress = addressModel?.address?.isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
          child: Text(
            AppHelpers.getTranslation(TrKeys.address),
            style: AppStyle.interSemi(size: 14, color: AppStyle.black),
          ),
        ),
        Material(
          color: AppStyle.white,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: () async {
              final data = await context.pushRoute(
                ViewMapRoute(isShopLocation: true, onChanged: () {}),
              );
              onAddressSelected(data);
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                border: Border.all(
                  color: hasAddress
                      ? AppStyle.primary.withOpacity(0.3)
                      : AppStyle.borderColor.withOpacity(0.3),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: hasAddress
                          ? AppStyle.primary.withOpacity(0.1)
                          : AppStyle.borderColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FlutterRemix.map_pin_line,
                      size: 22.r,
                      color: hasAddress ? AppStyle.primary : AppStyle.textGrey,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasAddress
                              ? AppHelpers.getTranslation(TrKeys.address)
                              : 'Select Location',
                          style: AppStyle.interNormal(
                            size: 13,
                            color: AppStyle.textGrey,
                          ),
                        ),
                        if (hasAddress) ...[
                          4.verticalSpace,
                          Text(
                            "${addressModel?.title ?? ""}, ${addressModel?.address ?? ""}",
                            style: AppStyle.interSemi(
                              size: 14,
                              color: AppStyle.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  8.horizontalSpace,
                  Icon(
                    FlutterRemix.arrow_right_s_line,
                    color: AppStyle.textGrey,
                    size: 20.r,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
