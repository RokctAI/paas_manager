import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'no_orders.dart';
import '../details/order_details_modal.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class ReadyOrdersBody extends StatefulWidget {
  final ScrollController? scrollController;

  const ReadyOrdersBody({super.key, this.scrollController});

  @override
  State<ReadyOrdersBody> createState() => _ReadyOrdersBodyState();
}

class _ReadyOrdersBodyState extends State<ReadyOrdersBody> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final event = ref.read(readyOrdersProvider.notifier);
        final state = ref.watch(readyOrdersProvider);
        return SmartRefresher(
          physics: const BouncingScrollPhysics(),
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: () =>
              event.fetchReadyOrders(refreshController: _refreshController),
          onRefresh: () => event.fetchReadyOrders(
            refreshController: _refreshController,
            isRefresh: true,
          ),
          child: state.isLoading
              ? const LoadingList(horizontalPadding: 16, verticalPadding: 16)
              : state.orders.isNotEmpty
              ? ListView.builder(
                  padding: REdgeInsets.only(
                    right: 16,
                    left: 16,
                    top: 16,
                    bottom: 100,
                  ),
                  shrinkWrap: true,
                  itemCount: state.orders.length,
                  controller: widget.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => OrderItem(
                    order: state.orders[index],
                    onTap: () => AppHelpers.showCustomModalBottomSheet(
                      paddingTop: MediaQuery.paddingOf(context).top + 60,
                      context: context,
                      radius: 12,
                      modal: OrderDetailsModal(
                        order: state.orders[index],
                        readyOrdersController: _refreshController,
                      ),
                      isDarkMode: true,
                    ),
                  ),
                )
              : const NoOrders(),
        );
      },
    );
  }
}
