import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/main_group_item.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../component/components.dart';
import 'details/extras_group_details_modal.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class ExtrasBody extends StatelessWidget {
  final RefreshController refreshController;

  const ExtrasBody({super.key, required this.refreshController});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(extrasProvider);
        final event = ref.read(extrasProvider.notifier);
        return SmartRefresher(
          physics: const NeverScrollableScrollPhysics(),
          controller: refreshController,
          onRefresh: () =>
              event.fetchGroups(refreshController: refreshController),
          child: state.isLoading
              ? Center(
                  child: SizedBox(
                    width: 30.r,
                    height: 30.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 4.r,
                      color: AppStyle.blackColor,
                    ),
                  ),
                )
              : state.groups.isEmpty
              ? NoDataInfo(title: AppHelpers.getTranslation(TrKeys.noData))
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.groups.length,
                  padding: REdgeInsets.only(
                    right: 16,
                    top: 20,
                    left: 16,
                    bottom: 100,
                  ),
                  itemBuilder: (context, index) => MainGroupItem(
                    group: state.groups[index],
                    onTap: () => AppHelpers.showCustomModalBottomSheet(
                      context: context,
                      modal: ExtrasGroupDetailsModal(
                        group: state.groups[index],
                      ),
                      isDarkMode: true,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
