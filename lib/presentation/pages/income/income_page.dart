import 'package:auto_route/auto_route.dart';

// import 'package:charts_flutter_new/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'widgets/chart.dart';
import 'widgets/statistics_section.dart';
import 'widgets/order_prices_section.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'app_bar_screen.dart';

@RoutePage()
class IncomePage extends ConsumerStatefulWidget {
  const IncomePage({super.key});

  @override
  ConsumerState<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends ConsumerState<IncomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    Tab(child: Text(AppHelpers.getTranslation(TrKeys.today))),
    Tab(child: Text(AppHelpers.getTranslation(TrKeys.weekly))),
    Tab(child: Text(AppHelpers.getTranslation(TrKeys.monthly))),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        ref
            .read(statisticsProvider.notifier)
            .fetchStatistics(
              startTime: DateTime.now(),
              endTime: DateTime.now(),
            );
      } else if (_tabController.index == 1) {
        ref
            .read(statisticsProvider.notifier)
            .fetchStatistics(
              startTime: DateTime.now(),
              endTime: DateTime.now().subtract(const Duration(days: 7)),
            );
      } else {
        ref
            .read(statisticsProvider.notifier)
            .fetchStatistics(
              startTime: DateTime.now(),
              endTime: DateTime.now().subtract(const Duration(days: 30)),
            );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(statisticsProvider.notifier)
          .fetchStatistics(startTime: DateTime.now(), endTime: DateTime.now());
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.greyColor,
      body: Column(
        children: [
          AppbarScreen(event: ref.read(statisticsProvider.notifier)),
          16.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                right: 16.w,
                left: 16.w,
                bottom: MediaQuery.of(context).padding.bottom + 56.h,
              ),
              child: Column(
                children: [
                  CustomTabBar(tabController: _tabController, tabs: _tabs),
                  24.verticalSpace,
                  OrderPricesSection(
                    startTime: DateTime.now(),
                    endTime: DateTime.now().subtract(
                      Duration(
                        days: _tabController.index == 0
                            ? 0
                            : _tabController.index == 1
                            ? 7
                            : 30,
                      ),
                    ),
                  ),
                  if (ref
                          .watch(statisticsProvider)
                          .countData
                          ?.chart
                          ?.isNotEmpty ??
                      false)
                    _chart(),
                  const StatisticsSection(),
                  20.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: REdgeInsets.all(16),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [PopButton(heroTag: AppConstants.heroTagIncomePage)],
        ),
      ),
    );
  }

  Column _chart() {
    return Column(
      children: [
        TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.earningsChart)),
        16.verticalSpace,
        Container(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: AppStyle.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SalesChart(
            price: ref.watch(statisticsProvider).prices,
            chart: ref.watch(statisticsProvider).countData?.chart ?? [],
            times: ref.watch(statisticsProvider).time,
            isDay: _tabController.index == 0,
            isLoading: false,
          ),
        ),
        // 16.verticalSpace,
        // Container(
        //   width: double.infinity,
        //   height: 300.h,
        //   decoration: BoxDecoration(
        //     color: Style.white,
        //     borderRadius: BorderRadius.circular(10.r),
        //   ),
        //   padding: EdgeInsets.all(16.r),
        //   child: Consumer(builder: (context, ref, child) {
        //     final state = ref.watch(statisticsProvider);
        //     return BarChart(
        //       state.list,
        //       animate: true,
        //       vertical: false,
        //       animationDuration: const Duration(seconds: 1),
        //       defaultRenderer: BarRendererConfig(
        //           cornerStrategy: const ConstCornerStrategy(6)),
        //       selectionModels: [
        //         SelectionModelConfig(changedListener: (d) {
        //           // AppHelpers.showAlertDialog(
        //           //   context: context,
        //           //   child: Column(
        //           //     mainAxisSize: MainAxisSize.min,
        //           //     children: [
        //           //       Text((d.selectedSeries.first.data.first as OrdinalSales)
        //           //           .day),
        //           //       8.verticalSpace,
        //           //       Text(
        //           //           "${AppHelpers.trans(TrKeys.price)}: ${(d.selectedSeries.first.data.first as OrdinalSales).sales}"),
        //           //     ],
        //           //   ),
        //           // );
        //         })
        //       ],
        //     );
        //   }),
        // ),
        32.verticalSpace,
      ],
    );
  }
}
