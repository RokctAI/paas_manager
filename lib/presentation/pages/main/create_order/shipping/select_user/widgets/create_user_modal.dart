import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import '../../../../../../../infrastructure/services/services.dart';

class CreateUserModal extends StatefulWidget {
  const CreateUserModal({super.key});

  @override
  State<CreateUserModal> createState() => _CreateUserModalState();
}

class _CreateUserModalState extends State<CreateUserModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final event = ref.read(createUserProvider.notifier);
            final state = ref.watch(createUserProvider);
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ModalDrag(),
                    TitleAndIcon(
                      title: AppHelpers.getTranslation(TrKeys.addUser),
                    ),
                    24.verticalSpace,
                    UnderlinedTextField(
                      label: '${AppHelpers.getTranslation(TrKeys.firstname)}*',
                      inputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      onChanged: event.setFirstname,
                      validator: AppValidators.emptyCheck,
                    ),
                    24.verticalSpace,
                    UnderlinedTextField(
                      label: '${AppHelpers.getTranslation(TrKeys.lastname)}*',
                      inputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      onChanged: event.setLastname,
                      validator: AppValidators.emptyCheck,
                    ),
                    24.verticalSpace,
                    UnderlinedTextField(
                      label:
                          '${AppHelpers.getTranslation(TrKeys.phoneNumber)}*',
                      inputType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onChanged: event.setPhone,
                      validator: AppValidators.emptyCheck,
                    ),
                    24.verticalSpace,
                    UnderlinedTextField(
                      label: '${AppHelpers.getTranslation(TrKeys.email)}*',
                      inputType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                      onChanged: event.setEmail,
                      validator: AppValidators.emptyCheck,
                    ),
                    24.verticalSpace,
                    CustomButton(
                      title: AppHelpers.getTranslation(TrKeys.save),
                      isLoading: state.isLoading,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          event.createUser(
                            context,
                            created: (user) {
                              context.maybePop();
                              ref
                                  .read(orderUserProvider.notifier)
                                  .addCreatedUser(user);
                            },
                            failed: () => AppHelpers.showCheckTopSnackBar(
                              context,
                              text: AppHelpers.getTranslation(TrKeys.failed),
                              type: SnackBarType.error,
                            ),
                          );
                        }
                      },
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
