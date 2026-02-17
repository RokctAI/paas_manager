import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:venderfoodyman/application/restaurant/income/statistics/statistics_provider.dart';
import 'package:venderfoodyman/presentation/component/filter_screen.dart';
import '../../component/helper/modal_drag.dart';
import '../../component/helper/modal_wrap.dart';
import '../../component/loading/loading.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class MoreOrders extends ConsumerStatefulWidget {
  final DateTime? endTime;
  final DateTime? startTime;

  const MoreOrders({super.key, required this.endTime, required this.startTime});

  @override
  ConsumerState<MoreOrders> createState() => _MoreOrdersState();
}

class _MoreOrdersState extends ConsumerState<MoreOrders> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(statisticsProvider.notifier)
          .fetchStatisticsOrder(
            startTime: widget.startTime,
            endTime: widget.endTime,
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalDrag(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppHelpers.getTranslation(TrKeys.moreOrders),
                      style: AppStyle.interSemi(size: 18),
                    ),
                    Text(
                      AppHelpers.getTranslation(TrKeys.moreOrders),
                      style: AppStyle.interNormal(
                        size: 14,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    AppHelpers.showCustomModalBottomSheet(
                      paddingTop: MediaQuery.of(context).padding.top,
                      context: context,
                      radius: 12,
                      modal: FilterScreen(
                        isTabBar: false,
                        onChangeDay: (rangeDatePicker) {
                          ref
                              .read(statisticsProvider.notifier)
                              .fetchStatisticsOrderByDay(
                                startTime:
                                    rangeDatePicker.last ?? DateTime.now(),
                                endTime:
                                    rangeDatePicker.first ?? DateTime.now(),
                              );
                        },
                      ),
                      isDarkMode: true,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: const BoxDecoration(
                      color: AppStyle.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FlutterRemix.calendar_event_fill,
                      color: AppStyle.black,
                    ),
                  ),
                ),
              ],
            ),
            40.verticalSpace,
            Expanded(
              child: ref.watch(statisticsProvider).isLoading
                  ? const Loading()
                  : SmartRefresher(
                      controller: _refreshController,
                      physics: const BouncingScrollPhysics(),
                      enablePullDown: true,
                      enablePullUp: true,
                      onLoading: () {
                        if (ref.watch(statisticsProvider).isRefresh) {
                          ref
                              .read(statisticsProvider.notifier)
                              .fetchStatisticsOrderPage(
                                refreshController: _refreshController,
                                startTime: widget.startTime,
                                endTime: widget.endTime,
                              );
                        } else {
                          _refreshController.loadNoData();
                        }
                      },
                      onRefresh: () => ref
                          .read(statisticsProvider.notifier)
                          .fetchStatisticsOrder(
                            startTime: widget.startTime,
                            endTime: widget.endTime,
                          ),
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(48),
                          1: FixedColumnWidth(80),
                          2: FixedColumnWidth(100),
                        },
                        border: TableBorder.all(color: AppStyle.transparent),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppStyle.black.withOpacity(.5),
                                ),
                              ),
                            ),
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.order),
                                    style: AppStyle.interSemi(
                                      size: 13,
                                      color: AppStyle.blackColor,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  6.verticalSpace,
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.price),
                                    style: AppStyle.interSemi(
                                      size: 13,
                                      color: AppStyle.blackColor,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.user),
                                    style: AppStyle.interSemi(
                                      size: 13,
                                      color: AppStyle.blackColor,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppHelpers.getTranslation(TrKeys.products),
                                    style: AppStyle.interSemi(
                                      size: 13,
                                      color: AppStyle.blackColor,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          for (
                            int i = 0;
                            i <
                                (ref
                                    .watch(statisticsProvider)
                                    .listOfOrder
                                    .length);
                            i++
                          )
                            TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppStyle.black.withOpacity(.3),
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "#${ref.watch(statisticsProvider).listOfOrder[i].id ?? 0}",
                                        style: AppStyle.interNormal(
                                          size: 12,
                                          color: AppStyle.blackColor,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        AppHelpers.numberFormat(
                                          ref
                                              .watch(statisticsProvider)
                                              .listOfOrder[i]
                                              .price,
                                        ),
                                        style: AppStyle.interSemi(
                                          size: 12,
                                          color: AppStyle.blackColor,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: REdgeInsets.symmetric(vertical: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ref
                                                .watch(statisticsProvider)
                                                .listOfOrder[i]
                                                .firstname ??
                                            '',
                                        style: AppStyle.interNormal(
                                          size: 12,
                                          color: AppStyle.blackColor,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: Wrap(
                                    runSpacing: 4.r,
                                    spacing: 4.r,
                                    children: [
                                      ...?ref
                                          .watch(statisticsProvider)
                                          .listOfOrder[i]
                                          .products
                                          ?.map(
                                            (e) => Text(
                                              e,
                                              style: AppStyle.interNormal(
                                                size: 12,
                                                color: AppStyle.blackColor,
                                                letterSpacing: -0.3,
                                              ),
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
            ),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }
}
