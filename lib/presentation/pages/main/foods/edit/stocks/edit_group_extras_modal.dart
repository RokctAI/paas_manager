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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class EditGroupExtrasModal extends ConsumerStatefulWidget {
  final int groupIndex;

  const EditGroupExtrasModal({super.key, required this.groupIndex})
      ;

  @override
  ConsumerState<EditGroupExtrasModal> createState() =>
      _EditGroupsExtrasModalState();
}

class _EditGroupsExtrasModalState extends ConsumerState<EditGroupExtrasModal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(editFoodStocksProvider.notifier)
          .fetchGroupExtras(context, groupIndex: widget.groupIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const ModalDrag(),
              TitleAndIcon(
                title: AppHelpers.getTranslation(TrKeys.extras),
                titleSize: 16,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(editFoodStocksProvider);
                  final event = ref.read(editFoodStocksProvider.notifier);
                  return state.isLoading
                      ? Padding(
                          padding: REdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3.r,
                              color: Style.primary,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: REdgeInsets.symmetric(vertical: 20),
                          shrinkWrap: true,
                          itemCount: state.activeGroupExtras.length,
                          itemBuilder: (context, index) => GroupExtrasItem(
                            extras: state.activeGroupExtras[index],
                            onTap: () => event.setActiveExtrasIndex(
                              itemIndex: index,
                              groupIndex: widget.groupIndex,
                            ),
                            isSelected: (state.selectGroups.values.any(
                                (element) => element.any((element) =>
                                    element?.id ==
                                    state.activeGroupExtras[index].id))),
                          ),
                        );
                },
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
