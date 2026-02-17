import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/main/orders/cooking/cooking_orders_provider.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'image_dialog.dart';
import 'price_information.dart';

class OrderDetailsModal extends ConsumerStatefulWidget {
  final OrderData order;
  final bool? isHistoryOrder;
  final RefreshController? newOrdersController;
  final RefreshController? acceptedOrdersController;
  final RefreshController? cookingOrdersController;
  final RefreshController? readyOrdersController;
  final RefreshController? onAWayOrdersController;

  const OrderDetailsModal({
    super.key,
    required this.order,
    this.isHistoryOrder,
    this.newOrdersController,
    this.acceptedOrdersController,
    this.cookingOrdersController,
    this.readyOrdersController,
    this.onAWayOrdersController,
  });

  @override
  ConsumerState<OrderDetailsModal> createState() => _OrderDetailsModalState();
}

class _OrderDetailsModalState extends ConsumerState<OrderDetailsModal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(orderDetailsProvider.notifier)
          .fetchOrderDetails(order: widget.order),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(orderDetailsProvider);
              final appbarState = ref.watch(homeAppbarProvider);
              final event = ref.read(orderDetailsProvider.notifier);
              final appbarEvent = ref.read(homeAppbarProvider.notifier);
              bool isHistoryOrder =
                  widget.isHistoryOrder ??
                  (state.order?.status == OrderStatus.delivered.name ||
                      state.order?.status == OrderStatus.canceled.name);
              return Column(
                children: [
                  const ModalDrag(),
                  Container(
                    decoration: BoxDecoration(
                      color: AppStyle.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: REdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CommonImage(
                                url: state.order?.user?.img,
                                radius: 25,
                                width: 50,
                                height: 50,
                              ),
                              12.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.order?.user == null
                                          ? AppHelpers.getTranslation(
                                              TrKeys.deletedUser,
                                            )
                                          : '${state.order?.user?.firstname ?? AppHelpers.getTranslation(TrKeys.noName)} ${state.order?.user?.lastname ?? ''}',
                                      style: AppStyle.interRegular(
                                        size: 14,
                                        color: AppStyle.blackColor,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      isHistoryOrder
                                          ? AppHelpers.getTranslation(
                                              state
                                                      .order
                                                      ?.transaction
                                                      ?.paymentSystem
                                                      ?.tag ??
                                                  "",
                                            )
                                          : '${AppHelpers.getTranslation(TrKeys.order)} - №${state.order?.id}',
                                      style: AppStyle.interNormal(
                                        size: 12,
                                        color: AppStyle.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        6.horizontalSpace,
                        Icon(
                          state.order?.deliveryType == TrKeys.dineIn
                              ? Icons.table_restaurant_outlined
                              : FlutterRemix.bank_card_2_line,
                          size: 20.r,
                          color: AppStyle.blackColor,
                        ),
                        6.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppHelpers.getTranslation(
                                state.order?.deliveryType == TrKeys.dineIn
                                    ? TrKeys.table
                                    : state
                                              .order
                                              ?.transaction
                                              ?.paymentSystem
                                              ?.tag ??
                                          TrKeys.noTransaction,
                              ),
                              style: AppStyle.interNormal(
                                size: 12,
                                color: AppStyle.blackColor,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              state.order?.deliveryType == TrKeys.dineIn
                                  ? state.order?.table?.name ?? ''
                                  : AppHelpers.numberFormat(
                                      state.order?.totalPrice?.isNegative ??
                                              true
                                          ? 0
                                          : state.order?.totalPrice ?? 0,
                                      symbol: state.order?.currency?.symbol,
                                    ),
                              style: AppStyle.interSemi(
                                size: 14,
                                color: AppStyle.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isHistoryOrder)
                    Container(
                      margin: EdgeInsets.only(top: 8.h),
                      decoration: BoxDecoration(
                        color: AppStyle.transparent,
                        border: Border.all(color: AppStyle.white),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: REdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppHelpers.getTranslation(TrKeys.order)} - №${state.order?.id}',
                            style: AppStyle.interNormal(
                              size: 14,
                              color: AppStyle.blackColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            '${DateFormat('hh:mm, EE').format(DateTime.tryParse(state.order?.createdAt ?? '')?.toLocal() ?? DateTime.now())} — ${DateFormat('hh:mm, EE').format(DateTime.tryParse(state.order?.updatedAt ?? '')?.toLocal() ?? DateTime.now())}',
                            style: AppStyle.interNormal(
                              size: 14,
                              color: AppStyle.blackColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isHistoryOrder)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppStyle.transparent,
                                border: Border.all(color: AppStyle.white),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              padding: REdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppStyle.blackColor,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(10.r),
                                    child: Center(
                                      child: Icon(
                                        FlutterRemix.wallet_3_fill,
                                        color: AppStyle.white,
                                        size: 18.r,
                                      ),
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppHelpers.getTranslation(
                                            TrKeys.yourBenefit,
                                          ),
                                          style: AppStyle.interNormal(
                                            size: 12,
                                            color: AppStyle.blackColor,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                        Text(
                                          AppHelpers.numberFormat(
                                            state.order?.deliveryFee ?? 0,
                                            symbol:
                                                state.order?.currency?.symbol,
                                          ),
                                          style: AppStyle.interSemi(
                                            size: 14,
                                            color: AppStyle.blackColor,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppStyle.transparent,
                                border: Border.all(color: AppStyle.white),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              padding: EdgeInsets.all(12.r),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: AppStyle.blackColor,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6.r),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/svg/logoWhite.svg",
                                        width: 22.r,
                                      ),
                                    ),
                                  ),
                                  12.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppHelpers.getTranslation(
                                            TrKeys.foodymanBenefit,
                                          ),
                                          style: AppStyle.interNormal(
                                            size: 12,
                                            color: AppStyle.blackColor,
                                            letterSpacing: -0.3,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          AppHelpers.numberFormat(
                                            state.order?.commissionFee ?? 0,
                                            symbol:
                                                state.order?.currency?.symbol,
                                          ),
                                          style: AppStyle.interSemi(
                                            size: 14,
                                            color: AppStyle.blackColor,
                                            letterSpacing: -0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isHistoryOrder &&
                      state.order?.afterDeliveredImage != null)
                    GestureDetector(
                      onTap: () {
                        AppHelpers.showAlertDialog(
                          context: context,
                          child: ImageDialog(
                            img: state.order?.afterDeliveredImage,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8.h),
                        decoration: BoxDecoration(
                          color: AppStyle.transparent,
                          border: Border.all(color: AppStyle.white),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: REdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppHelpers.getTranslation(TrKeys.orderImage),
                              style: AppStyle.interNormal(
                                size: 14,
                                color: AppStyle.blackColor,
                                letterSpacing: -0.3,
                              ),
                            ),
                            12.horizontalSpace,
                            const Icon(FlutterRemix.gallery_fill),
                          ],
                        ),
                      ),
                    ),
                  8.verticalSpace,
                  (state.order?.details != null &&
                          (state.order?.details?.isNotEmpty ?? false) &&
                          state.order != null)
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppStyle.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: REdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: ListView.builder(
                            itemCount: state.order?.details?.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => OrderProductItem(
                              currencyData: state.order?.currency,
                              orderDetail: state.order!.details![index],
                              isLoading: state.isLoading,
                              isLast: state.order?.details?.length == index + 1,
                              onToggle: () =>
                                  event.toggleOrderDetailChecked(index: index),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  if (state.order?.note?.trim().isNotEmpty ?? false)
                    Container(
                      decoration: BoxDecoration(
                        color: AppStyle.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      margin: REdgeInsets.only(top: 8),
                      padding: REdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FlutterRemix.chat_1_fill,
                            size: 24.r,
                            color: AppStyle.blackColor,
                          ),
                          12.horizontalSpace,
                          Expanded(
                            child: Text(
                              state.order?.note ?? '',
                              style: AppStyle.interRegular(
                                size: 13,
                                color: AppStyle.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  Container(
                    decoration: BoxDecoration(
                      color: AppStyle.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    margin: REdgeInsets.only(top: 8),
                    padding: REdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppHelpers.getTranslation(TrKeys.otpCode),
                          style: AppStyle.interRegular(
                            size: 12,
                            color: AppStyle.textGrey,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              (state.order?.otp ?? 0).toString(),
                              style: AppStyle.interRegular(
                                size: 14,
                                color: AppStyle.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PriceInformation(
                    order: state.order,
                    isHistoryOrder: widget.isHistoryOrder,
                  ),
                  isHistoryOrder
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            20.verticalSpace,
                            state.isUpdating
                                ? const Loading()
                                : CustomButton(
                                    title: AppHelpers.changeStatusButtonText(
                                      state.order?.status,
                                    ),
                                    onPressed: () => event.updateOrderStatus(
                                      context,
                                      status: AppHelpers.getUpdatableStatus(
                                        state.order?.status,
                                      ),
                                      success: () {
                                        Navigator.pop(context);
                                        switch (AppHelpers.getOrderStatus(
                                          state.order?.status,
                                        )) {
                                          case OrderStatus.newOrder:
                                            ref
                                                .read(
                                                  newOrdersProvider.notifier,
                                                )
                                                .fetchNewOrders(
                                                  context: context,
                                                  isRefresh: true,
                                                  activeTabIndex:
                                                      appbarState.index,
                                                  updateTotal: (count) =>
                                                      appbarEvent.setAppbarDetails(
                                                        AppHelpers.getTranslation(
                                                          TrKeys.newOrders,
                                                        ),
                                                        count,
                                                      ),
                                                );
                                            ref
                                                .read(
                                                  acceptedOrdersProvider
                                                      .notifier,
                                                )
                                                .fetchAcceptedOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .acceptedOrdersController,
                                                );
                                            break;
                                          case OrderStatus.accepted:
                                            ref
                                                .read(
                                                  acceptedOrdersProvider
                                                      .notifier,
                                                )
                                                .fetchAcceptedOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .acceptedOrdersController,
                                                  updateTotal: (count) =>
                                                      appbarEvent.setAppbarDetails(
                                                        AppHelpers.getTranslation(
                                                          TrKeys.acceptedOrders,
                                                        ),
                                                        count,
                                                      ),
                                                );
                                            ref
                                                .read(
                                                  cookingOrdersProvider
                                                      .notifier,
                                                )
                                                .fetchCookingOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .cookingOrdersController,
                                                );
                                            break;
                                          case OrderStatus.cooking:
                                            ref
                                                .read(
                                                  cookingOrdersProvider
                                                      .notifier,
                                                )
                                                .fetchCookingOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .cookingOrdersController,
                                                );
                                            ref
                                                .read(
                                                  readyOrdersProvider.notifier,
                                                )
                                                .fetchReadyOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .readyOrdersController,
                                                );
                                            break;
                                          case OrderStatus.ready:
                                            ref
                                                .read(
                                                  readyOrdersProvider.notifier,
                                                )
                                                .fetchReadyOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .readyOrdersController,
                                                  updateTotal: (count) =>
                                                      appbarEvent.setAppbarDetails(
                                                        AppHelpers.getTranslation(
                                                          TrKeys.readyOrders,
                                                        ),
                                                        count,
                                                      ),
                                                );
                                            ref
                                                .read(
                                                  onAWayOrdersProvider.notifier,
                                                )
                                                .fetchOnAWayOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .onAWayOrdersController,
                                                );
                                            break;
                                          case OrderStatus.onAWay:
                                            ref
                                                .read(
                                                  onAWayOrdersProvider.notifier,
                                                )
                                                .fetchOnAWayOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .onAWayOrdersController,
                                                  updateTotal: (count) =>
                                                      appbarEvent.setAppbarDetails(
                                                        AppHelpers.getTranslation(
                                                          TrKeys.onAWayOrders,
                                                        ),
                                                        count,
                                                      ),
                                                );
                                            ref
                                                .read(
                                                  onAWayOrdersProvider.notifier,
                                                )
                                                .fetchOnAWayOrders(
                                                  isRefresh: true,
                                                  refreshController: widget
                                                      .onAWayOrdersController,
                                                );
                                            break;
                                          default:
                                            ref
                                                .read(
                                                  newOrdersProvider.notifier,
                                                )
                                                .fetchNewOrders(
                                                  context: context,
                                                  isRefresh: true,
                                                  activeTabIndex:
                                                      appbarState.index,
                                                  updateTotal: (count) =>
                                                      appbarEvent.setAppbarDetails(
                                                        AppHelpers.getTranslation(
                                                          TrKeys.newOrders,
                                                        ),
                                                        count,
                                                      ),
                                                );
                                            break;
                                        }
                                      },
                                    ),
                                  ),
                          ],
                        ),
                  20.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
