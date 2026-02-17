import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import '../main/orders/widgets/no_orders.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import '../main/orders/details/order_details_modal.dart';

@RoutePage()
class OrderHistoryPage extends ConsumerStatefulWidget {
  const OrderHistoryPage({super.key}) ;

  @override
  ConsumerState<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends ConsumerState<OrderHistoryPage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(orderProvider.notifier).fetchHistoryOrders(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderProvider);
    final event = ref.read(orderProvider.notifier);
    return Scaffold(
      backgroundColor: Style.greyColor,
      body: Column(
        children: [
          CustomAppBar(
            bottomPadding: 16.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppHelpers.getTranslation(TrKeys.orderHistory),
                  style: Style.interSemi(size: 18.sp),
                ),
                Text(
                  '${AppHelpers.getTranslation(TrKeys.thereAre)} ${state.totalCount} ${AppHelpers.getTranslation(TrKeys.orders)}',
                  style: Style.interRegular(size: 12.sp, letterSpacing: -0.3),
                ),
              ],
            ),
          ),
          Expanded(
            child: SmartRefresher(
              physics: const BouncingScrollPhysics(),
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () => event.fetchHistoryOrders(
                refreshController: _refreshController,
              ),
              onRefresh: () => event.fetchHistoryOrders(
                refreshController: _refreshController,
                isRefresh: true,
              ),
              child: state.isLoading
                  ? const LoadingList(
                      horizontalPadding: 16,
                      verticalPadding: 16,
                    )
                  : state.orders.isNotEmpty
                      ? ListView.builder(
                          padding: REdgeInsets.only(
                            right: 16,
                            left: 16,
                            top: 16,
                            bottom: 86,
                          ),
                          shrinkWrap: true,
                          itemCount: state.orders.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => OrderItem(
                            isHistoryOrder: true,
                            order: state.orders[index],
                            onTap: () => AppHelpers.showCustomModalBottomSheet(
                              paddingTop:
                                  MediaQuery.paddingOf(context).top + 60,
                              context: context,
                              radius: 12,
                              modal: OrderDetailsModal(
                                isHistoryOrder: true,
                                order: state.orders[index],
                              ),
                              isDarkMode: true,
                            ),
                          ),
                        )
                      : const NoOrders(),
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
                    ref.read(orderProvider.notifier).fetchHistoryOrders(
                        isRefresh: true,
                        start: rangeDatePicker.last,
                        end: rangeDatePicker.first);
                  },
                ),
                isDarkMode: true,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Style.primary,
                ),
                padding: REdgeInsets.all(16),
                child: const Icon(FlutterRemix.equalizer_fill),
              ),
            )
          ],
        ),
      ),
    );
  }
}
