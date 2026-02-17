import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'foods_filter_item.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodsFilterModal extends ConsumerStatefulWidget {
  const FoodsFilterModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FoodsFilterModalState();
}

class _FoodsFilterModalState extends ConsumerState<FoodsFilterModal> {
  List rating = ['2.5 - 3.5', '3.5 - 4.5', '4.5 - 5.0', '5.0'];
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(filterProvider.notifier).init(context);
    });
    _controller.addListener(() {
      if (_controller.value) {
        // ref.read(filterProvider.notifier).setCheck(context, true);
      } else {
        // ref.read(filterProvider.notifier).setCheck(context, false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    final state = ref.watch(foodsFilterProvider);
    final event = ref.read(foodsFilterProvider.notifier);
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: AppStyle.greyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: REdgeInsets.all(16),
          child: ListView(
            primary: false,
            children: [
              18.verticalSpace,
              TitleAndIcon(
                title:
                    '${AppHelpers.getTranslation(TrKeys.filter)} (${!state.isLoading ? state.shopCount : AppHelpers.getTranslation(TrKeys.loading)})',
                rightTitleColor: AppStyle.red,
                rightTitle: AppHelpers.getTranslation(TrKeys.clearAll),
                onRightTap: event.clear,
              ),
              state.isTagLoading
                  ? Padding(
                      padding: REdgeInsets.only(top: 56),
                      child: const Loading(),
                    )
                  : Column(
                      children: [
                        8.verticalSpace,
                        // _priceRange(state, event),
                        8.verticalSpace,
                        FoodsFilterItem(
                          title: AppHelpers.getTranslation(TrKeys.rating),
                          list: rating,
                          isRating: true,
                          // currentItem: state.filterModel?.rating,
                          onTap: (s) {
                            // if (s == state.filterModel?.rating) {
                            //   state.filterModel?.rating = null;
                            // } else {
                            //   state.filterModel?.rating = s;
                            // }
                            // event.setFilterModel(context, state.filterModel);
                          },
                        ),
                        8.verticalSpace,
                        // FoodsFilterItem(
                        //   title: AppHelpers.getTranslation(TrKeys.sortBy),
                        //   list: sorts,
                        //   isSort: true,
                        //   currentItem: state.filterModel?.sort,
                        //   onTap: (s) {
                        //     if (s == state.filterModel?.sort) {
                        //       state.filterModel?.sort = null;
                        //     } else {
                        //       state.filterModel?.sort = s;
                        //     }
                        //     event.setFilterModel(context, state.filterModel);
                        //   },
                        // ),
                        8.verticalSpace,
                        CustomToggle(
                          controller: _controller,
                          onChange: (value) {},
                        ),
                        40.verticalSpace,
                        CustomButton(
                          isLoading: state.isLoading,
                          background: AppStyle.blackColor,
                          textColor: AppStyle.white,
                          title:
                              '${AppHelpers.getTranslation(TrKeys.show)} ${state.shopCount} ${AppHelpers.getTranslation(TrKeys.shopAndRestaurants)} ',
                          onPressed: () {
                            // context.pushRoute(const ResultFilter());
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Container _priceRange(FilterState state, FilterNotifier event) {
  //   return Container(
  //     width: double.infinity,
  //     padding:
  //         EdgeInsets.only(left: 10.w, right: 10.w, top: 18.h, bottom: 10.h),
  //     decoration: BoxDecoration(
  //       color: Style.white.withOpacity(0.9),
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(10.r),
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           AppHelpers.getTranslation(TrKeys.priceRange),
  //           style: Style.interNoSemi(
  //             size: 16,
  //             color: Style.black,
  //           ),
  //         ),
  //         18.verticalSpace,
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(bottom: 2.h),
  //               child: SizedBox(
  //                 width: 46.w,
  //                 child: Text(
  //                   intl.AppHelpers.numberFormat(
  //                           symbol: LocalStorage
  //                               .getSelectedCurrency()
  //                               .symbol,
  //                           decimalDigits: 0)
  //                       .format(double.tryParse(
  //                           state.rangeValues.start.toString())),
  //                   style: Style.interNormal(
  //                     size: 14,
  //                     color: Style.black,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Column(
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       right: 24.r,
  //                     ),
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         for (int i = 0; i < state.prices.length; i++)
  //                           Container(
  //                             width: 10.w,
  //                             height: 100.h / state.prices[i],
  //                             decoration: BoxDecoration(
  //                                 color: ((state.rangeValues.start /
  //                                                     (state.endPrice / 20))
  //                                                 .round() <=
  //                                             i) &&
  //                                         ((state.rangeValues.end /
  //                                                     (state.endPrice / 20))
  //                                                 .round() >=
  //                                             i)
  //                                     ? Style.brandGreen
  //                                     : Style.bgGrey,
  //                                 borderRadius: BorderRadius.circular(48.r)),
  //                           )
  //                       ],
  //                     ),
  //                   ),
  //                   8.verticalSpace,
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       right: 24.r,
  //                     ),
  //                     child: RangeSlider(
  //                         activeColor: Style.brandGreen,
  //                         inactiveColor: Style.bgGrey,
  //                         min: 1,
  //                         max: state.endPrice,
  //                         values: state.rangeValues,
  //                         onChanged: (value) {
  //                           event.setRange(
  //                               RangeValues(value.start, value.end), context);
  //                         }),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(bottom: 2.h),
  //               child: SizedBox(
  //                 width: 50.w,
  //                 child: Text(
  //                   intl.AppHelpers.numberFormat(
  //                           symbol: LocalStorage
  //                               .getSelectedCurrency()
  //                               .symbol,
  //                           decimalDigits: 0)
  //                       .format(
  //                           double.tryParse(state.rangeValues.end.toString())),
  //                   style: Style.interNormal(
  //                     size: 14,
  //                     color: Style.black,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
