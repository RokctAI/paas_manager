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

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'no_orders.dart';
import '../details/order_details_modal.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class NewOrdersBody extends StatelessWidget {
  final ScrollController? scrollController;

  const NewOrdersBody({super.key, this.scrollController}) ;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final event = ref.read(newOrdersProvider.notifier);
        final state = ref.watch(newOrdersProvider);
        final appbarState = ref.watch(homeAppbarProvider);
        return SmartRefresher(
          physics: const BouncingScrollPhysics(),
          controller: state.refreshController!,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: () => event.fetchNewOrders(
              context: context, activeTabIndex: appbarState.index),
          onRefresh: () => event.fetchNewOrders(
            context: context,
            isRefresh: true,
            activeTabIndex: appbarState.index,
          ),
          child: state.isLoading
              ? const LoadingList(
                  horizontalPadding: 16,
                  verticalPadding: 16,
                )
              : state.orders.isNotEmpty
                  ? ListView.builder(
                      padding: REdgeInsets.only(
                          right: 16, left: 16, top: 16, bottom: 100),
                      shrinkWrap: true,
                      itemCount: state.orders.length,
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => OrderItem(
                        order: state.orders[index],
                        onTap: () => AppHelpers.showCustomModalBottomSheet(
                          paddingTop: MediaQuery.paddingOf(context).top + 60,
                          context: context,
                          radius: 12,
                          modal: OrderDetailsModal(
                            order: state.orders[index],
                            newOrdersController: state.refreshController,
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
