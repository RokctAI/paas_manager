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

import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class AddFoodCategoryModal extends StatelessWidget {
  const AddFoodCategoryModal({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(addCategoryProvider);
          final event = ref.read(addCategoryProvider.notifier);
          return Column(
            children: [
              TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.addNewCategory)),
              24.verticalSpace,
              UnderlinedTextField(
                label: AppHelpers.getTranslation(TrKeys.categoryName),
                inputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
                onChanged: event.setTitle,
              ),
              36.verticalSpace,
              CustomButton(
                title: AppHelpers.getTranslation(TrKeys.save),
                isLoading: state.isLoading,
                onPressed: () => event.createCategory(
                  context,
                  success: () {
                    ref
                        .read(addFoodCategoriesProvider.notifier)
                        .updateCategories(context);
                    context.maybePop();
                  },
                ),
              ),
              20.verticalSpace,
            ],
          );
        },
      ),
    );
  }
}
