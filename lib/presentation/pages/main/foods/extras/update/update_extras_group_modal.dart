import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class UpdateExtrasGroupModal extends ConsumerStatefulWidget {
  final Group group;

  const UpdateExtrasGroupModal({super.key, required this.group});

  @override
  ConsumerState<UpdateExtrasGroupModal> createState() =>
      _UpdateExtrasGroupModalState();
}

class _UpdateExtrasGroupModalState
    extends ConsumerState<UpdateExtrasGroupModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(updateExtrasGroupProvider.notifier)
          .setTitle(widget.group.translation?.title ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(updateExtrasGroupProvider);
            final event = ref.read(updateExtrasGroupProvider.notifier);
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ModalDrag(),
                  TitleAndIcon(title: AppHelpers.getTranslation(TrKeys.edit)),
                  24.verticalSpace,
                  UnderlinedTextField(
                    label: AppHelpers.getTranslation(TrKeys.title),
                    inputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    onChanged: event.setTitle,
                    validator: AppValidators.emptyCheck,
                    initialText: widget.group.translation?.title,
                  ),
                  36.verticalSpace,
                  CustomButton(
                    title: AppHelpers.getTranslation(TrKeys.save),
                    isLoading: state.isLoading,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        event.updateExtrasGroup(
                          context,
                          groupId: widget.group.id,
                          success: () {
                            ref.read(extrasProvider.notifier).fetchGroups();
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
    );
  }
}
