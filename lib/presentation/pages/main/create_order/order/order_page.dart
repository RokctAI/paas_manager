import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/presentation/routes/app_router.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

@RoutePage()
class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(orderPaymentProvider.notifier)
          .getCalculate(
            stocks: ref.watch(orderCartProvider).stocks,
            type: 'pickup',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.greyColor,
      body: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(orderCartProvider);
          final event = ref.read(orderCartProvider.notifier);
          final paymentState = ref.watch(orderPaymentProvider);
          final paymentNotifier = ref.read(orderPaymentProvider.notifier);
          final productsEvent = ref.read(orderProductsProvider.notifier);
          return Column(
            children: [
              CustomAppBar(
                bottomPadding: 16.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShopBorderedAvatar(
                      size: 40,
                      imageSize: 33,
                      borderRadius: 20,
                      imageUrl: LocalStorage.getShop()?.logoImg,
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            LocalStorage.getShop()?.translation?.title ?? '',
                            style: AppStyle.interSemi(size: 18),
                          ),
                          Text(
                            LocalStorage.getShop()?.translation?.description ??
                                '',
                            style: AppStyle.interRegular(
                              size: 12,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: REdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 24,
                  bottom: 16,
                ),
                child: TitleAndIcon(
                  title: AppHelpers.getTranslation(TrKeys.orders),
                  rightTitleColor: AppStyle.red,
                  rightTitle: state.stocks.isEmpty
                      ? null
                      : AppHelpers.getTranslation(TrKeys.clearAllOrders),
                  onRightTap: () {
                    event.clearAll();
                    productsEvent.updateProducts(cartStocks: []);
                    paymentNotifier.clearAll();
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: SlidableAutoCloseBehavior(
                  child: paymentState.isCalculateLoading
                      ? const LoadingList(itemPadding: 2)
                      : ListView.builder(
                          padding: REdgeInsets.only(
                            bottom: MediaQuery.paddingOf(context).bottom + 68,
                          ),
                          shrinkWrap: true,
                          itemCount:
                              paymentState.orderCalculate?.stocks?.length ?? 0,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => FoodStockItem(
                            product:
                                paymentState.orderCalculate?.stocks?[index],
                            onDelete: () => event.deleteStockFromCart(
                              stock:
                                  paymentState.orderCalculate?.stocks?[index] ??
                                  Stock(),
                              updateProducts: (stocks) => productsEvent
                                  .updateProducts(cartStocks: stocks),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: REdgeInsets.all(16),
        child: Consumer(
          builder: (context, ref, child) {
            final cartState = ref.watch(orderCartProvider);
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const PopButton(heroTag: AppConstants.heroTagAddOrderButton),
                8.horizontalSpace,
                if (cartState.stocks.isNotEmpty)
                  Expanded(
                    child: CustomButton(
                      title: AppHelpers.getTranslation(TrKeys.next),
                      onPressed: () =>
                          context.pushRoute(const ShippingAddressRoute()),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
