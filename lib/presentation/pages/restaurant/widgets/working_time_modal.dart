import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class WorkingTimeModal extends ConsumerStatefulWidget {
  const WorkingTimeModal({super.key});

  @override
  ConsumerState<WorkingTimeModal> createState() => _WorkingTimeModalState();
}

class _WorkingTimeModalState extends ConsumerState<WorkingTimeModal> {
  late List<ShopWorkingDays> _workingDays;
  late List<ShopWorkingDays> _savingWorkingDays;
  bool _shouldUpdate = false;
  List temp = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _workingDays = ref.read(restaurantProvider).shop?.shopWorkingDays ?? [];
      if (_workingDays.isNotEmpty) {
        for (int i = 0; i < _workingDays.length; i++) {
          temp.add(_workingDays[i].day);
        }
        for (int i = 0; i < WeekDays.values.length; i++) {
          if (temp.contains(WeekDays.values[i].name)) {
            continue;
          } else {
            _workingDays.add(
              ShopWorkingDays(
                id: i,
                day: WeekDays.values[i].name,
                from: "00:00",
                to: "00:00",
                disabled: false,
              ),
            );
          }
        }
      } else {
        for (int i = 0; i < WeekDays.values.length; i++) {
          _workingDays.add(
            ShopWorkingDays(
              id: i,
              day: WeekDays.values[i].name,
              from: "00:00",
              to: "00:00",
              disabled: false,
            ),
          );
        }
      }
      _savingWorkingDays = _workingDays;
      ref.read(workingDaysProvider.notifier).setShopWorkingDays(_workingDays);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(workingDaysProvider);
            final shopState = ref.watch(restaurantProvider);
            final event = ref.read(workingDaysProvider.notifier);
            final shopEvent = ref.read(restaurantProvider.notifier);
            return state.workingDays.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3.r,
                      color: AppStyle.primary,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ModalDrag(),
                      TitleAndIcon(
                        title: AppHelpers.getTranslation(TrKeys.workingHours),
                      ),
                      Text(
                        AppHelpers.getTranslation(TrKeys.enterOpeningHours),
                        style: AppStyle.interNormal(
                          size: 14,
                          color: AppStyle.blackColor,
                        ),
                      ),
                      24.verticalSpace,
                      SizedBox(
                        height: 40.r,
                        width: MediaQuery.sizeOf(context).width - 32.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ..._workingDays.map(
                              (ShopWorkingDays day) => GestureDetector(
                                onTap: () {
                                  event.changeIndex(day);
                                  _savingWorkingDays = _workingDays;
                                },
                                child: SmallWeekdayItem(
                                  isSelected:
                                      state.currentIndex ==
                                      _workingDays.indexOf(day),
                                  day: day,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppHelpers.getTranslation(TrKeys.setBusinessDay),
                            style: AppStyle.interNormal(
                              size: 16,
                              letterSpacing: -0.3,
                            ),
                          ),
                          CustomToggle(
                            key: UniqueKey(),
                            controller: ValueNotifier<bool>(
                              !(_savingWorkingDays[state.currentIndex]
                                      .disabled ??
                                  false),
                            ),
                            onChange: (value) {
                              _setDisabledDay(
                                currentIndex: state.currentIndex,
                                disabled: value,
                              );
                            },
                          ),
                        ],
                      ),
                      40.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 160.h,
                              child: CupertinoDatePicker(
                                key: UniqueKey(),
                                mode: CupertinoDatePickerMode.time,
                                initialDateTime: DateTime(
                                  2022,
                                  1,
                                  1,
                                  int.parse(
                                    _savingWorkingDays[state.currentIndex].from
                                            ?.substring(0, 2) ??
                                        '',
                                  ),
                                  int.parse(
                                    _savingWorkingDays[state.currentIndex].from
                                            ?.substring(3, 5) ??
                                        '',
                                  ),
                                ),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  _setTimeToDay(
                                    time: TimeOfDay.fromDateTime(newDateTime),
                                    currentIndex: state.currentIndex,
                                  );
                                },
                                use24hFormat: true,
                                minuteInterval: 1,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 160.h,
                              child: CupertinoDatePicker(
                                key: UniqueKey(),
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                minuteInterval: 1,
                                initialDateTime: DateTime(
                                  2022,
                                  1,
                                  1,
                                  int.parse(
                                    _savingWorkingDays[state.currentIndex].to
                                            ?.substring(0, 2) ??
                                        '',
                                  ),
                                  int.parse(
                                    _savingWorkingDays[state.currentIndex].to
                                            ?.substring(3, 5) ??
                                        '',
                                  ),
                                ),
                                onDateTimeChanged: (DateTime newDateTime) {
                                  _setTimeToDay(
                                    time: TimeOfDay.fromDateTime(newDateTime),
                                    isFrom: false,
                                    currentIndex: state.currentIndex,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      40.verticalSpace,
                      CustomButton(
                        title: AppHelpers.getTranslation(TrKeys.save),
                        isLoading: state.isLoading,
                        onPressed: () {
                          _savingWorkingDays = _workingDays;
                          if (_shouldUpdate) {
                            event.updateWorkingDays(
                              days: _savingWorkingDays,
                              shopUuid: shopState.shop?.uuid,
                              updateSuccess: () {
                                shopEvent.updateWorkingDays(_savingWorkingDays);
                                context.maybePop();
                              },
                            );
                          }
                        },
                      ),
                      30.verticalSpace,
                    ],
                  );
          },
        ),
      ),
    );
  }

  void _setDisabledDay({bool? disabled, required int currentIndex}) {
    _shouldUpdate = true;
    _workingDays[currentIndex] = _workingDays[currentIndex].copyWith(
      disabled: !(disabled ?? false),
    );
  }

  void _setTimeToDay({
    required TimeOfDay time,
    bool isFrom = true,
    required int currentIndex,
  }) {
    _shouldUpdate = true;
    if (isFrom) {
      _workingDays[currentIndex] = _workingDays[currentIndex].copyWith(
        from:
            '${time.hour.toString().padLeft(2, '0')}-${time.minute.toString().padLeft(2, '0')}',
      );
    } else {
      _workingDays[currentIndex] = _workingDays[currentIndex].copyWith(
        to: '${time.hour.toString().padLeft(2, '0')}-${time.minute.toString().padLeft(2, '0')}',
      );
    }
  }
}
