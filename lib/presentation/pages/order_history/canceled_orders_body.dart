import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../application/order/order_provider.dart';
import '../../../infrastructure/services/app_helpers.dart';
import '../../component/list_items/order_item.dart';
import '../../component/loading/loading_list.dart';
import '../main/orders/details/order_details_modal.dart';
import '../main/orders/widgets/no_orders.dart';

class CanceledOrdersBody extends ConsumerStatefulWidget {
  final RefreshController refreshController;

  const CanceledOrdersBody({super.key, required this.refreshController});

  @override
  ConsumerState<CanceledOrdersBody> createState() => _CanceledOrdersBodyState();
}

class _CanceledOrdersBodyState extends ConsumerState<CanceledOrdersBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderProvider);
    final event = ref.read(orderProvider.notifier);
    return SmartRefresher(
      physics: const BouncingScrollPhysics(),
      controller: widget.refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: () => event.fetchCanceledOrders(
        refreshController: widget.refreshController,
      ),
      onRefresh: () => event.fetchCanceledOrders(
        refreshController: widget.refreshController,
        isRefresh: true,
      ),
      child: state.isLoading
          ? const LoadingList(horizontalPadding: 16, verticalPadding: 16)
          : state.canceledOrders.isNotEmpty
          ? ListView.builder(
              padding: REdgeInsets.only(
                right: 16,
                left: 16,
                top: 16,
                bottom: 86,
              ),
              // shrinkWrap: true,
              itemCount: state.canceledOrders.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => OrderItem(
                isHistoryOrder: true,
                order: state.canceledOrders[index],
                onTap: () => AppHelpers.showCustomModalBottomSheet(
                  paddingTop: MediaQuery.paddingOf(context).top + 60,
                  context: context,
                  radius: 12,
                  modal: OrderDetailsModal(
                    isHistoryOrder: true,
                    order: state.canceledOrders[index],
                  ),
                  isDarkMode: true,
                ),
              ),
            )
          : const NoOrders(),
    );
  }
}
