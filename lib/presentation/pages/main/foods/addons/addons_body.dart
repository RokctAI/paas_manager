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

import 'widgets/addon_item.dart';
import 'edit/edit_addon_modal.dart';
import '../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class AddonsBody extends StatelessWidget {
  final RefreshController addonsController;

  const AddonsBody({super.key, required this.addonsController})
      ;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(addonsProvider);
        final event = ref.read(addonsProvider.notifier);
        return state.isLoading
            ? const LoadingList(
                verticalPadding: 16,
                itemBorderRadius: 0,
                itemPadding: 10,
              )
            : SmartRefresher(
                controller: addonsController,
                physics: const NeverScrollableScrollPhysics(),
                enablePullDown: true,
                enablePullUp: true,
                onLoading: () =>
                    event.fetchMoreAddons(refreshController: addonsController),
                onRefresh: () =>
                    event.refreshAddons(refreshController: addonsController),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: REdgeInsets.only(top: 16),
                  shrinkWrap: true,
                  itemCount: state.addons.length,
                  itemBuilder: (context, index) => AddonItem(
                    addon: state.addons[index],
                    onTap: () {
                      ref
                          .read(editAddonProvider.notifier)
                          .setAddonDetails(state.addons[index]);
                      ref
                          .read(editAddonUnitsProvider.notifier)
                          .setAddonUnit(state.addons[index].unit);
                      AppHelpers.showCustomModalBottomSheet(
                        paddingTop: 60,
                        context: context,
                        modal: EditAddonModal(addon: state.addons[index]),
                        isDarkMode: false,
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
