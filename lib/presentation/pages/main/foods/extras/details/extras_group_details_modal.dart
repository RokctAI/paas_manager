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
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'widgets/edit_extras_item_modal.dart';
import 'widgets/delete_extras_item_modal.dart';
import 'widgets/group_detail_extras_item.dart';
import '../delete/delete_extras_group_modal.dart';
import '../update/update_extras_group_modal.dart';
import '../../../../../component/components.dart';
import 'widgets/create_new_group_item_modal.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class ExtrasGroupDetailsModal extends ConsumerStatefulWidget {
  final Group group;

  const ExtrasGroupDetailsModal({super.key, required this.group})
      ;

  @override
  ConsumerState<ExtrasGroupDetailsModal> createState() =>
      _ExtrasGroupDetailsModalState();
}

class _ExtrasGroupDetailsModalState
    extends ConsumerState<ExtrasGroupDetailsModal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(extrasGroupDetailsProvider.notifier)
          .fetchGroupExtras(groupId: widget.group.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const ModalDrag(),
            ButtonsBouncingEffect(
              child: GestureDetector(
                onTap: () => AppHelpers.showCustomModalBottomSheet(
                  context: context,
                  modal: CreateNewGroupItemModal(group: widget.group),
                  isDarkMode: false,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FlutterRemix.play_list_add_line,
                      color: Style.blue,
                      size: 18.r,
                    ),
                    10.horizontalSpace,
                    Text(
                      AppHelpers.getTranslation(TrKeys.addNewExtras),
                      style: Style.interSemi(
                        size: 14,
                        color: Style.blue,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            UnderlinedTextField(
              label: '',
              readOnly: true,
              initialText: widget.group.translation?.title,
              onTap: () => AppHelpers.showCustomModalBottomSheet(
                context: context,
                modal: UpdateExtrasGroupModal(group: widget.group),
                isDarkMode: true,
              ),
              suffixIcon: widget.group.shopId == LocalStorage.getShop()?.id
                  ? GestureDetector(
                      onTap: () => AppHelpers.showCustomModalBottomSheet(
                        context: context,
                        isDarkMode: true,
                        modal: DeleteExtrasGroupModal(group: widget.group),
                      ),
                      child: Icon(
                        FlutterRemix.delete_bin_fill,
                        size: 24.r,
                        color: Style.red,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(extrasGroupDetailsProvider);
                  return state.isLoading
                      ? Center(
                          child: SizedBox(
                            width: 30.r,
                            height: 30.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 4.r,
                              color: Style.blackColor,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: REdgeInsets.only(top: 16, bottom: 24),
                          shrinkWrap: true,
                          itemCount: state.extras.length,
                          itemBuilder: (context, index) =>
                              GroupDetailExtrasItem(
                            extras: state.extras[index],
                            onEditTap: () =>
                                AppHelpers.showCustomModalBottomSheet(
                              context: context,
                              modal: EditExtrasItemModal(
                                group: widget.group,
                                extras: state.extras[index],
                              ),
                              isDarkMode: false,
                            ),
                            onDeleteTap: () =>
                                AppHelpers.showCustomModalBottomSheet(
                              context: context,
                              modal: DeleteExtrasItemModal(
                                extras: state.extras[index],
                              ),
                              isDarkMode: false,
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
