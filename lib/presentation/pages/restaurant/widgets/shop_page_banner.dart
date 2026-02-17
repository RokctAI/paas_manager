import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class ShopBanner extends StatelessWidget {
  const ShopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 200.h,
      toolbarHeight: 56.h,
      backgroundColor: AppStyle.white,
      flexibleSpace: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(restaurantProvider);
          return FlexibleSpaceBar(
            title: Stack(
              children: [
                Positioned(
                  bottom: 8.r,
                  left: 16.r,
                  child: ShopBorderedAvatar(
                    imageUrl:
                        state.shop?.logoImg ?? LocalStorage.getShop()?.logoImg,
                    imageSize: 36,
                    size: 46,
                    borderRadius: 12,
                    bgColor: AppStyle.greyColor.withOpacity(0.65),
                  ),
                ),
                Positioned(
                  top: 8.r,
                  left: 72.r,
                  child: Text(
                    '${state.shop?.translation?.title ?? LocalStorage.getShop()?.translation?.title}',
                    style: AppStyle.interSemi(
                      size: 16,
                      color: AppStyle.blackColor,
                    ),
                  ),
                ),
              ],
            ),
            titlePadding: REdgeInsets.only(
              top: MediaQuery.paddingOf(context).top,
            ),
            background: Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: Container(
                height: 150.h + MediaQuery.paddingOf(context).top,
                width: double.infinity,
                color: AppStyle.greyColor,
                child: CommonImage(
                  url:
                      state.shop?.backgroundImg ??
                      LocalStorage.getShop()?.backgroundImg,
                  width: double.infinity,
                  radius: 0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
