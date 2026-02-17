import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class EditFoodAddonsModal extends ConsumerStatefulWidget {
  final Stock stock;
  final Function(List<ProductData>) onSave;

  const EditFoodAddonsModal({
    super.key,
    required this.stock,
    required this.onSave,
  });

  @override
  ConsumerState<EditFoodAddonsModal> createState() =>
      _EditFoodAddonsModalState();
}

class _EditFoodAddonsModalState extends ConsumerState<EditFoodAddonsModal> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(editFoodAddonsProvider.notifier)
          .initialFetchAddons(widget.stock),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(editFoodAddonsProvider);
            final event = ref.read(editFoodAddonsProvider.notifier);
            return Column(
              children: [
                const ModalDrag(),
                Expanded(
                  child: state.isLoading
                      ? Center(
                          child: SizedBox(
                            width: 30.r,
                            height: 30.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 4.r,
                              color: AppStyle.blackColor,
                            ),
                          ),
                        )
                      : SmartRefresher(
                          enablePullDown: false,
                          controller: _refreshController,
                          child: ListView.builder(
                            itemCount: state.addons.length,
                            itemBuilder: (context, index) =>
                                SelectableAddonItem(
                                  addon: state.addons[index],
                                  isLast: state.addons.length - 1 == index,
                                  onTap: () =>
                                      event.toggleAddonSelection(index),
                                ),
                          ),
                        ),
                ),
                CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.save),
                  onPressed: () {
                    widget.onSave(state.addons);
                    context.maybePop();
                  },
                ),
                20.verticalSpace,
              ],
            );
          },
        ),
      ),
    );
  }
}
