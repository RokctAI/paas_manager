import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/main/orders/cooking/cooking_orders_provider.dart';
import 'package:venderfoodyman/presentation/pages/main/orders/widgets/cooking_orders_body.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'widgets/new_orders_body.dart';
import 'widgets/ready_orders_body.dart';
import 'widgets/accepted_orders_body.dart';
import 'widgets/on_a_way_orders_body.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class OrdersHomePage extends ConsumerStatefulWidget {
  const OrdersHomePage({super.key});

  @override
  ConsumerState<OrdersHomePage> createState() => _OrdersHomePageState();
}

class _OrdersHomePageState extends ConsumerState<OrdersHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _newController;
  ScrollController? _acceptedController;
  ScrollController? _readyController;
  ScrollController? _onAWayController;
  ScrollController? _cookingController;

  final _tabs = [
    Tab(child: Icon(FlutterRemix.fire_fill, size: 22.r)),
    Tab(child: Icon(FlutterRemix.check_double_fill, size: 22.r)),
    Tab(child: Icon(FlutterRemix.restaurant_fill, size: 22.r)),
    Tab(child: Icon(FlutterRemix.time_fill, size: 22.r)),
    Tab(child: Icon(FlutterRemix.takeaway_fill, size: 22.r)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController?.addListener(() {
      if (!(_tabController?.indexIsChanging ?? false)) {
        String title = AppHelpers.getTranslation(TrKeys.newOrders);
        int count = ref.watch(newOrdersProvider).totalCount;
        switch (_tabController?.index) {
          case 0:
            title = AppHelpers.getTranslation(TrKeys.newOrders);
            count = ref.watch(newOrdersProvider).totalCount;
            break;
          case 1:
            title = AppHelpers.getTranslation(TrKeys.acceptedOrders);
            count = ref.watch(acceptedOrdersProvider).totalCount;
            break;
          case 2:
            title = AppHelpers.getTranslation(TrKeys.cookingOrders);
            count = ref.watch(cookingOrdersProvider).totalCount;
            break;
          case 3:
            title = AppHelpers.getTranslation(TrKeys.readyOrders);
            count = ref.watch(readyOrdersProvider).totalCount;
            break;
          case 4:
            title = AppHelpers.getTranslation(TrKeys.onAWayOrders);
            count = ref.watch(onAWayOrdersProvider).totalCount;
            break;
          default:
            title = AppHelpers.getTranslation(TrKeys.newOrders);
            count = ref.watch(newOrdersProvider).totalCount;
            break;
        }
        ref
            .read(homeAppbarProvider.notifier)
            .setAppbarDetails(title, count, index: _tabController?.index);
      }
    });
    _newController = ScrollController();
    _acceptedController = ScrollController();
    _readyController = ScrollController();
    _onAWayController = ScrollController();
    _cookingController = ScrollController();
    _newController?.addListener(() => listen(_newController));
    _acceptedController?.addListener(() => listen(_acceptedController));
    _cookingController?.addListener(() => listen(_cookingController));
    _readyController?.addListener(() => listen(_readyController));
    _onAWayController?.addListener(() => listen(_onAWayController));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(newOrdersProvider.notifier)
          .fetchNewOrders(
            context: context,
            activeTabIndex: ref.watch(homeAppbarProvider).index,
            updateTotal: (count) => ref
                .read(homeAppbarProvider.notifier)
                .setAppbarDetails(
                  AppHelpers.getTranslation(TrKeys.newOrders),
                  count,
                  index: 0,
                ),
          );
      ref.read(acceptedOrdersProvider.notifier).fetchAcceptedOrders();
      ref.read(cookingOrdersProvider.notifier).fetchCookingOrders();
      ref.read(readyOrdersProvider.notifier).fetchReadyOrders();
      ref.read(onAWayOrdersProvider.notifier).fetchOnAWayOrders();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
    _newController?.removeListener(() => listen(_newController));
    _acceptedController?.removeListener(() => listen(_acceptedController));
    _cookingController?.removeListener(() => listen(_cookingController));
    _readyController?.removeListener(() => listen(_readyController));
    _onAWayController?.removeListener(() => listen(_onAWayController));
    _newController?.dispose();
    _acceptedController?.dispose();
    _cookingController?.dispose();
    _readyController?.dispose();
    _onAWayController?.dispose();
  }

  void listen(ScrollController? controller) {
    final direction = controller?.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      ref.read(mainProvider.notifier).changeScrolling(true);
    } else if (direction == ScrollDirection.forward) {
      ref.read(mainProvider.notifier).changeScrolling(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppStyle.greyColor,
        body: Column(
          children: [
            CustomAppBar(
              bottomPadding: 16.r,
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppStyle.greyColor,
                      ),
                      padding: REdgeInsets.all(12),
                      child: Icon(
                        FlutterRemix.dashboard_3_line,
                        size: 20.r,
                        color: AppStyle.blackColor,
                      ),
                    ),
                    10.horizontalSpace,
                    Consumer(
                      builder: (context, ref, child) {
                        final state = ref.watch(homeAppbarProvider);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              state.title.isEmpty
                                  ? AppHelpers.getTranslation(TrKeys.newOrders)
                                  : state.title,
                              style: AppStyle.interNormal(size: 12),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${state.totalCount} ${AppHelpers.getTranslation(TrKeys.orders).toLowerCase()}',
                                  style: AppStyle.interSemi(
                                    size: 14,
                                    color: AppStyle.blackColor,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppStyle.blackColor,
                                  size: 20.r,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: CustomTabBar(tabController: _tabController, tabs: _tabs),
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  NewOrdersBody(scrollController: _newController),
                  AcceptedOrdersBody(scrollController: _acceptedController),
                  CookingOrdersBody(scrollController: _cookingController),
                  ReadyOrdersBody(scrollController: _readyController),
                  OnAWayOrdersBody(scrollController: _onAWayController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
