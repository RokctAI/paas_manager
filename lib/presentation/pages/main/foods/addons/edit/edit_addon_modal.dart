import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'edit_addon_units_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class EditAddonModal extends StatefulWidget {
  final ProductData addon;

  const EditAddonModal({super.key, required this.addon});

  @override
  State<EditAddonModal> createState() => _EditAddonModalState();
}

class _EditAddonModalState extends State<EditAddonModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: ModalWrap(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const ModalDrag(),
              TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.edit)),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(editAddonProvider);
                    final unitState = ref.watch(editAddonUnitsProvider);
                    final event = ref.read(editAddonProvider.notifier);
                    final addonsEvent = ref.read(addonsProvider.notifier);
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  24.verticalSpace,
                                  UnderlinedTextField(
                                    label:
                                        '${AppHelpers.getTranslation(TrKeys.title)}*',
                                    inputType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textInputAction: TextInputAction.next,
                                    onChanged: event.setTitle,
                                    validator: AppValidators.emptyCheck,
                                    initialText:
                                        widget.addon.translation?.title,
                                  ),
                                  24.verticalSpace,
                                  UnderlinedTextField(
                                    label:
                                        '${AppHelpers.getTranslation(TrKeys.description)}*',
                                    inputType: TextInputType.text,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textInputAction: TextInputAction.next,
                                    onChanged: event.setDescription,
                                    validator: AppValidators.emptyCheck,
                                    initialText:
                                        widget.addon.translation?.description,
                                  ),
                                  24.verticalSpace,
                                  UnderlinedTextField(
                                    textController: unitState.unitController,
                                    label:
                                        '${AppHelpers.getTranslation(TrKeys.units)}*',
                                    suffixIcon: Icon(
                                      FlutterRemix.arrow_down_s_line,
                                      color: AppStyle.blackColor,
                                      size: 18.r,
                                    ),
                                    readOnly: true,
                                    validator: AppValidators.emptyCheck,
                                    onTap: () =>
                                        AppHelpers.showCustomModalBottomSheet(
                                          paddingTop:
                                              MediaQuery.paddingOf(
                                                context,
                                              ).top +
                                              300.h,
                                          context: context,
                                          modal: const EditAddonUnitsModal(),
                                          isDarkMode: false,
                                        ),
                                  ),
                                  24.verticalSpace,
                                  UnderlinedTextField(
                                    label:
                                        '${AppHelpers.getTranslation(TrKeys.tax)}*',
                                    inputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    onChanged: event.setTax,
                                    validator: AppValidators.emptyCheck,
                                    initialText: widget.addon.tax == null
                                        ? ''
                                        : widget.addon.tax.toString(),
                                  ),
                                  24.verticalSpace,
                                  UnderlinedTextField(
                                    label:
                                        '${AppHelpers.getTranslation(TrKeys.sku)}*',
                                    inputType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    onChanged: event.setBarcode,
                                    validator: AppValidators.emptyCheck,
                                    initialText: widget.addon.barCode ?? '',
                                  ),
                                  24.verticalSpace,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: UnderlinedTextField(
                                          label:
                                              '${AppHelpers.getTranslation(TrKeys.price)}*',
                                          inputType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          onChanged: event.setPrice,
                                          validator: AppValidators.emptyCheck,
                                          initialText:
                                              AppHelpers.getInitialAddonPrice(
                                                widget.addon,
                                              ),
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Expanded(
                                        child: UnderlinedTextField(
                                          label:
                                              '${AppHelpers.getTranslation(TrKeys.quantity)}*',
                                          inputType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          onChanged: event.setQuantity,
                                          validator: AppValidators.emptyCheck,
                                          initialText:
                                              AppHelpers.getInitialAddonQuantity(
                                                widget.addon,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  24.verticalSpace,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppHelpers.getTranslation(
                                          TrKeys.active,
                                        ),
                                        style: AppStyle.interNormal(
                                          size: 14,
                                          letterSpacing: -0.3,
                                          color: AppStyle.blackColor,
                                        ),
                                      ),
                                      CustomToggle(
                                        controller: ValueNotifier<bool>(
                                          widget.addon.active ?? false,
                                        ),
                                        onChange: event.setActive,
                                      ),
                                    ],
                                  ),
                                  24.verticalSpace,
                                ],
                              ),
                            ),
                          ),
                          CustomButton(
                            title: AppHelpers.getTranslation(TrKeys.save),
                            isLoading: state.isLoading,
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                event.updateAddon(
                                  context,
                                  uuid: widget.addon.uuid,
                                  unit: unitState.foodUnit,
                                  updated: () {
                                    AppHelpers.showCheckTopSnackBar(
                                      context,
                                      text: AppHelpers.getTranslation(
                                        TrKeys.successfullyCreated,
                                      ),
                                      type: SnackBarType.success,
                                    );
                                    addonsEvent.refreshAddons();
                                    context.router.popUntilRoot();
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
            ],
          ),
        ),
      ),
    );
  }
}
