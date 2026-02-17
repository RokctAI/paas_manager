import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_addon_units_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class CreateAddonModal extends ConsumerStatefulWidget {
  const CreateAddonModal({super.key});

  @override
  ConsumerState<CreateAddonModal> createState() => _CreateAddonModalState();
}

class _CreateAddonModalState extends ConsumerState<CreateAddonModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(createAddonProvider.notifier).updateAddonInfo(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: ModalWrap(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const ModalDrag(),
              TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.addons)),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(createAddonProvider);
                    final unitState = ref.watch(createAddonUnitsProvider);
                    final event = ref.read(createAddonProvider.notifier);
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
                                  ),
                                  24.verticalSpace,
                                  Consumer(
                                    builder: (context, ref, child) {
                                      return UnderlinedTextField(
                                        textController:
                                            unitState.unitController,
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
                                                  MediaQuery.of(
                                                    context,
                                                  ).padding.top +
                                                  300.h,
                                              context: context,
                                              modal:
                                                  const CreateAddonUnitsModal(),
                                              isDarkMode: false,
                                            ),
                                      );
                                    },
                                  ),
                                  24.verticalSpace,
                                  UnderlinedTextField(
                                    label:
                                        '${AppHelpers.getTranslation(TrKeys.tax)}*',
                                    inputType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    onChanged: event.setTax,
                                    validator: AppValidators.minQtyCheck,
                                  ),
                                  24.verticalSpace,
                                  UnderlinedTextField(
                                    label: AppHelpers.getTranslation(
                                      TrKeys.sku,
                                    ),
                                    inputType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    onChanged: event.setBarcode,
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
                                          validator: AppValidators.minQtyCheck,
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
                                          validator: AppValidators.minQtyCheck,
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
                                        controller: ValueNotifier<bool>(true),
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
                                event.createAddon(
                                  context,
                                  unitId:
                                      unitState.units[unitState.activeIndex].id,
                                  created: () {
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
