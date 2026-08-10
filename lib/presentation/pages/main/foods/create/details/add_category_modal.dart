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
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'food_categories_modal.dart';

class AddCategoryModal extends StatefulWidget {
  const AddCategoryModal({super.key}) ;

  @override
  State<AddCategoryModal> createState() => _AddCategoryModalState();
}

class _AddCategoryModalState extends State<AddCategoryModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(addCategoryProvider);
            final event = ref.read(addCategoryProvider.notifier);
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ModalDrag(),
                  TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.addNewCategory)),
                  24.verticalSpace,
                  Consumer(
                    builder: (context, ref, child) {
                      return UnderlinedTextField(
                        textController: ref
                            .watch(addFoodCategoriesProvider)
                            .categorySubController,
                        label: '${AppHelpers.getTranslation(TrKeys.subShopCategory)}*',
                        suffixIcon: Icon(
                          FlutterRemix.arrow_down_s_line,
                          color: Style.blackColor,
                          size: 18.r,
                        ),
                        readOnly: true,
                        validator: AppValidators.emptyCheck,
                        onTap: () => AppHelpers.showCustomModalBottomSheet(
                          paddingTop:
                              MediaQuery.paddingOf(context).top + 100.h,
                          context: context,
                          modal: const FoodCategoriesModal(
                            isSubCategory: true,
                          ),
                          isDarkMode: false,
                        ),
                      );
                    },
                  ),
                  24.verticalSpace,
                  UnderlinedTextField(
                    label: AppHelpers.getTranslation(TrKeys.categoryName),
                    inputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    onChanged: event.setTitle,
                    validator: AppValidators.emptyCheck,
                  ),
                  24.verticalSpace,
                  UnderlinedTextField(
                    label: AppHelpers.getTranslation(TrKeys.input),
                    inputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: event.setInput,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  36.verticalSpace,
                  CustomButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    isLoading: state.isLoading,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        event.createCategory(
                          context,
                          success: () {
                            ref
                                .read(addFoodCategoriesProvider.notifier)
                                .updateCategories(context);
                            Navigator.pop(context);
                            AppHelpers.showAlertDialog(
                                context: context,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppHelpers.getTranslation(
                                          TrKeys.thanksForCategory),
                                      style: Style.interNormal(),
                                      textAlign: TextAlign.center,
                                    ),
                                    16.verticalSpace,
                                    if (AppHelpers.getAppPhone() != null)
                                      CustomButton(
                                          title: AppHelpers.getAppPhone() ?? "",
                                          onPressed: () {
                                            final Uri launchUri = Uri(
                                              scheme: 'tel',
                                              path: AppHelpers.getAppPhone(),
                                            );
                                            launchUrl(launchUri);
                                          })
                                  ],
                                ));
                          },
                        );
                      }
                    },
                  ),
                  20.verticalSpace,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
