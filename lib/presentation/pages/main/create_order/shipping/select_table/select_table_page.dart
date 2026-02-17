import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/order/shipping/table/table_provider.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

import 'widgets/table_item.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';

@RoutePage()
class SelectTablePage extends ConsumerStatefulWidget {
  final int? sectionId;

  const SelectTablePage({super.key, required this.sectionId});

  @override
  ConsumerState<SelectTablePage> createState() => _SelectTablePageState();
}

class _SelectTablePageState extends ConsumerState<SelectTablePage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(tableProvider.notifier)
          .initialFetchTables(sectionId: widget.sectionId);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Scaffold(
        backgroundColor: AppStyle.greyColor,
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(tableProvider);
            final event = ref.read(tableProvider.notifier);
            return Column(
              children: [
                CustomAppBar(
                  bottomPadding: 4.h,
                  child: SearchTextField(
                    onChanged: (value) => event.setQuery(
                      sectionId: widget.sectionId,
                      refreshController: _refreshController,
                      text: value,
                    ),
                  ),
                ),
                Expanded(
                  child: state.isLoading
                      ? const Loading()
                      : SmartRefresher(
                          controller: _refreshController,
                          enablePullUp: true,
                          onRefresh: () => event.refreshTables(
                            sectionId: widget.sectionId,
                            refreshController: _refreshController,
                          ),
                          onLoading: () => event.fetchMoreTables(
                            sectionId: widget.sectionId,
                            refreshController: _refreshController,
                          ),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.tables.length,
                            shrinkWrap: true,
                            padding: REdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 20,
                              bottom: 80,
                            ),
                            itemBuilder: (context, index) => TableItem(
                              table: state.tables[index],
                              isSelected: index == state.selectedIndex,
                              onTap: () {
                                event.setSelectTable(index);
                                context.maybePop();
                              },
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: REdgeInsets.all(16),
          child: Row(
            children: [
              const PopButton(heroTag: AppConstants.heroTagAddOrderButton),
              8.horizontalSpace,
              Expanded(
                child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.close),
                  onPressed: context.maybePop,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
