import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'canceled_orders_body.dart';
import 'delivered_order_body.dart';

@RoutePage()
class OrderHistoryPage extends ConsumerStatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  ConsumerState<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends ConsumerState<OrderHistoryPage>
    with SingleTickerProviderStateMixin {
  late RefreshController _deliveredRefreshController;
  late RefreshController _canceledRefreshController;

  late TabController _tabController;

  final List<Tab> tabs = <Tab>[
    Tab(text: AppHelpers.getTranslation(TrKeys.delivered)),
    Tab(text: AppHelpers.getTranslation(TrKeys.canceled)),
  ];

  int count = 0;

  @override
  void initState() {
    super.initState();
    _deliveredRefreshController = RefreshController();
    _canceledRefreshController = RefreshController();
    _tabController = TabController(length: tabs.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderProvider.notifier)
        ..fetchCanceledOrders(isRefresh: true)
        ..fetchDeliveredOrders(isRefresh: true);
    });
    _tabController.addListener(() {
      ref.read(orderProvider.notifier).changeIndex(_tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _deliveredRefreshController.dispose();
    _canceledRefreshController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderProvider);
    return Scaffold(
      backgroundColor: AppStyle.greyColor,
      body: Column(
        children: [
          CustomAppBar(
            height: 120,
            bottomPadding: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.orderHistory),
                  style: AppStyle.interSemi(size: 18),
                ),
                Text(
                  '${AppHelpers.getTranslation(TrKeys.thereAre)} ${state.totalCount} ${AppHelpers.getTranslation(TrKeys.orders)}',
                  style: AppStyle.interRegular(
                    size: 12,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          12.verticalSpace,
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: CustomTabBar(tabs: tabs, tabController: _tabController),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DeliveredOrdersBody(
                  refreshController: _deliveredRefreshController,
                ),
                CanceledOrdersBody(
                  refreshController: _canceledRefreshController,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const PopButton(heroTag: AppConstants.heroTagOrderHistory),

            GestureDetector(
              onTap: () => AppHelpers.showCustomModalBottomSheet(
                paddingTop: MediaQuery.paddingOf(context).top,
                context: context,
                radius: 12,
                modal: FilterScreen(
                  onChangeDay: (rangeDatePicker) {
                    ref
                        .read(orderProvider.notifier)
                        .fetchHistoryOrders(
                          isRefresh: true,
                          start: rangeDatePicker.last,
                          end: rangeDatePicker.first,
                        );
                  },
                ),
                isDarkMode: true,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppStyle.primary,
                ),
                padding: REdgeInsets.all(16),
                child: Icon(
                  FlutterRemix.equalizer_fill,
                  color: AppStyle.buttonFontColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
