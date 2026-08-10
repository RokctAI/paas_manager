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
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/foods/create/details/kitchens/create_food_kitchens_provider.dart';
import 'package:venderfoodyman/presentation/component/list_items/food_kitchen_item.dart';

import '../../../../../component/components.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class CreateFoodKitchensModal extends ConsumerStatefulWidget {
  const CreateFoodKitchensModal({super.key});

  @override
  ConsumerState<CreateFoodKitchensModal> createState() =>
      _CreateFoodKitchensModalState();
}

class _CreateFoodKitchensModalState
    extends ConsumerState<CreateFoodKitchensModal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) =>
          ref.read(createFoodKitchensProvider.notifier).fetchKitchens(context),
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
            TitleAndIcon(
                title: AppHelpers.getTranslation(TrKeys.kitchens),
                titleSize: 16),
            24.verticalSpace,
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final state = ref.watch(createFoodKitchensProvider);
                  final event = ref.read(createFoodKitchensProvider.notifier);
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: state.kitchens.length,
                    itemBuilder: (context, index) => FoodKitchenItem(
                      kitchen: state.kitchens[index],
                      onTap: () => event.setActiveIndex(index),
                      isSelected: state.activeIndex == index,
                    ),
                  );
                },
              ),
            ),
            24.verticalSpace,
            CustomButton(
              title: AppHelpers.getTranslation(TrKeys.close),
              onPressed: context.maybePop,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
