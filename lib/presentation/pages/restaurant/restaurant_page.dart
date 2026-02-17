import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'widgets/logout_button.dart';
import 'widgets/logout_modal.dart';
import 'widgets/sections_item.dart';
import 'widgets/shop_page_banner.dart';
import '../../component/components.dart';
import '../../phoenix_widget.dart';
import '../auth/languages_modal.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import 'widgets/edit_restaurant_modal.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class RestaurantPage extends ConsumerStatefulWidget {
  const RestaurantPage({super.key});

  @override
  ConsumerState<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends ConsumerState<RestaurantPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => listen(_controller));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() => listen(_controller));
  }

  void listen(ScrollController controller) {
    final direction = controller.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      ref.read(mainProvider.notifier).changeScrolling(true);
    } else if (direction == ScrollDirection.forward) {
      ref.read(mainProvider.notifier).changeScrolling(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppStyle.white,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            slivers: <Widget>[
              const ShopBanner(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(restaurantProvider);
                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: REdgeInsets.only(
                          right: 16,
                          left: 16,
                          bottom: MediaQuery.paddingOf(context).bottom,
                        ),
                        shrinkWrap: true,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppHelpers.truncate(
                                  state.shop?.translation?.title ??
                                      LocalStorage.getShop()
                                          ?.translation
                                          ?.title ??
                                      "",
                                  16,
                                ),
                                style: AppStyle.interSemi(
                                  size: 22,
                                  color: AppStyle.blackColor,
                                ),
                              ),
                              Container(
                                width: 4.w,
                                height: 4.h,
                                margin: REdgeInsets.symmetric(horizontal: 8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyle.textColor,
                                ),
                              ),
                              Icon(
                                FlutterRemix.star_smile_fill,
                                color: AppStyle.starColor,
                                size: 20.r,
                              ),
                              4.horizontalSpace,
                              Text(
                                '${LocalStorage.getShop()?.ratingAvg?.toStringAsFixed(1) ?? 0.0}',
                                style: AppStyle.interNormal(
                                  size: 12,
                                  color: AppStyle.blackColor,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: 22.r,
                                height: 22.r,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyle.red,
                                ),
                                child: Icon(
                                  FlutterRemix.percent_fill,
                                  color: AppStyle.white,
                                  size: 12.r,
                                ),
                              ),
                              14.horizontalSpace,
                              Container(
                                width: 22.r,
                                height: 22.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppStyle.primary,
                                ),
                                child: Icon(
                                  FlutterRemix.flashlight_fill,
                                  size: 16.r,
                                  color: AppStyle.buttonFontColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${state.shop?.translation?.description}',
                            style: AppStyle.interNormal(
                              size: 13,
                              color: AppStyle.blackColor,
                            ),
                          ),
                          Container(
                            height: 46.r,
                            margin: EdgeInsets.only(top: 24.h, bottom: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: AppStyle.borderColor,
                                width: 1.r,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FlutterRemix.time_fill,
                                  size: 20.r,
                                  color: AppStyle.blackColor,
                                ),
                                10.horizontalSpace,
                                RichText(
                                  text: TextSpan(
                                    text:
                                        AppHelpers.getTranslation(
                                              TrKeys.theRestaurantIsClosedToday,
                                            ) ==
                                            AppHelpers.getShopWorkingTimeForToday()
                                        ? ''
                                        : '${AppHelpers.getTranslation(TrKeys.workingHours)}:',
                                    style: AppStyle.interRegular(
                                      color: AppStyle.blackColor,
                                      size: 12,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            ' ${AppHelpers.getShopWorkingTimeForToday()}',
                                        style: AppStyle.interSemi(
                                          color: AppStyle.blackColor,
                                          size: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 74.r,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppStyle.borderColor),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: REdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FlutterRemix.coins_fill,
                                    size: 45.r,
                                    color: AppStyle.blackColor,
                                  ),
                                  10.horizontalSpace,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppHelpers.getTranslation(
                                          TrKeys.balance,
                                        ),
                                        style: AppStyle.interNormal(
                                          size: 14,
                                          color: AppStyle.blackColor,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      Text(
                                        AppHelpers.numberFormat(
                                          LocalStorage.getShop()
                                              ?.seller
                                              ?.wallet
                                              ?.price,
                                          symbol: LocalStorage.getShop()
                                              ?.seller
                                              ?.wallet
                                              ?.symbol,
                                        ),
                                        style: AppStyle.interSemi(
                                          size: 18,
                                          color: AppStyle.blackColor,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 1.r,
                                    height: 46.r,
                                    color: AppStyle.blackColor.withOpacity(0.1),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    FlutterRemix.bar_chart_line,
                                    size: 24.r,
                                    color: AppStyle.blackColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // _notification(context),
                          16.verticalSpace,
                          _sections(context),
                        ],
                      );
                    },
                  ),
                ]),
              ),
            ],
          ),
          Consumer(
            builder: (context, ref, child) {
              return LogoutButton(
                isOpen: ref.watch(restaurantProvider).shop?.open ?? false,
                onChange: () {
                  ref.read(restaurantProvider.notifier).setOnlineOffline();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sections(BuildContext context) {
    return Column(
      children: [
        TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.sections)),
        20.verticalSpace,
        SectionsItem(
          title: AppHelpers.getTranslation(TrKeys.restaurantSettings),
          icon: FlutterRemix.restaurant_line,
          onTap: () => AppHelpers.showCustomModalBottomSheet(
            paddingTop: MediaQuery.paddingOf(context).top + 60,
            context: context,
            modal: const EditRestaurantModal(),
            isDarkMode: false,
          ),
        ),
        SectionsItem(
          title: AppHelpers.getTranslation(TrKeys.income),
          icon: FlutterRemix.line_chart_line,
          onTap: () => context.pushRoute(const IncomeRoute()),
        ),
        SectionsItem(
          title: AppHelpers.getTranslation(TrKeys.myOrderHistory),
          icon: FlutterRemix.history_line,
          onTap: () => context.pushRoute(const OrderHistoryRoute()),
        ),
        SectionsItem(
          title: AppHelpers.getTranslation(TrKeys.notifications),
          icon: FlutterRemix.notification_2_line,
          onTap: () => context.pushRoute(const NotificationListRoute()),
        ),
        SectionsItem(
          title: AppHelpers.getTranslation(TrKeys.language),
          icon: FlutterRemix.translate,
          onTap: () => AppHelpers.showCustomModalBottomSheet(
            paddingTop: MediaQuery.paddingOf(context).top + 60,
            context: context,
            modal: LanguageScreen(
              afterUpdate: (lang) {
                Phoenix.rebirth(context);
              },
            ),
            isDarkMode: false,
          ),
        ),
        if (LocalStorage.getSubscription())
          SectionsItem(
            title: AppHelpers.getTranslation(TrKeys.subscriptions),
            icon: Icons.verified_outlined,
            onTap: () => context.pushRoute(SubscriptionsRoute()),
          ),
        if (!AppConstants.isDemo)
          SectionsItem(
            title: AppHelpers.getTranslation(TrKeys.deleteAccount),
            icon: FlutterRemix.logout_box_r_line,
            onTap: () {
              AppHelpers.showCustomModalBottomSheet(
                context: context,
                modal: const LogoutModal(isDeleteAccount: true),
                isDarkMode: false,
              );
            },
          ),
        // SectionsItem(
        //   title: AppHelpers.trans(TrKeys.settings),
        //   icon: FlutterRemix.settings_3_line,
        //   onTap: () {},
        // ),
        100.verticalSpace,
      ],
    );
  }

  // Widget _notification(BuildContext context) {
  //   return Column(
  //     children: [
  //       46.verticalSpace,
  //       Row(
  //         children: [
  //           Container(
  //             decoration: const BoxDecoration(
  //               color: Style.primaryColor,
  //               shape: BoxShape.circle,
  //             ),
  //             height: 30.h,
  //             width: 30.w,
  //             child: Center(
  //               child: Text(
  //                 '4',
  //                 style: Style.interSemi(size: 14, color: Style.blackColor),
  //               ),
  //             ),
  //           ),
  //           12.horizontalSpace,
  //           Text(
  //             AppHelpers.trans(TrKeys.notifications),
  //             style: Style.interSemi(size: 18, color: Style.blackColor),
  //           ),
  //           const Spacer(),
  //           GestureDetector(
  //             onTap: () => context.pushRoute(const ListNotificationRoute()),
  //             child: Padding(
  //               padding: const EdgeInsets.all(4.0),
  //               child: Text(
  //                 AppHelpers.trans(TrKeys.seeAll),
  //                 style: Style.interNormal(size: 14, color: Style.blueColor),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       16.verticalSpace,
  //       SizedBox(
  //         height: 136.h,
  //         child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: 4,
  //           physics: const BouncingScrollPhysics(),
  //           itemBuilder: (context, index) => const NotificationItem(
  //             date: 'June 24',
  //             text: 'Check your settings you have notifications turned off',
  //           ),
  //         ),
  //       ),
  //       40.verticalSpace,
  //     ],
  //   );
  // }
}
