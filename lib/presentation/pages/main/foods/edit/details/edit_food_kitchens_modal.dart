import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/foods/edit/details/kitchen/edit_food_kitchens_provider.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/components.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class EditFoodKitchensModal extends ConsumerStatefulWidget {
  const EditFoodKitchensModal({super.key});

  @override
  ConsumerState<EditFoodKitchensModal> createState() =>
      _EditFoodKitchensModalState();
}

class _EditFoodKitchensModalState extends ConsumerState<EditFoodKitchensModal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(editFoodKitchensProvider.notifier).fetchKitchens(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ModalDrag(),
            TitleAndIcon(
              title: AppHelpers.getTranslation(TrKeys.kitchens),
              titleSize: 16,
            ),
            24.verticalSpace,
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(editFoodKitchensProvider);
                final event = ref.read(editFoodKitchensProvider.notifier);
                return state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3.r,
                          color: AppStyle.primary,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.kitchens.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => FoodKitchenItem(
                            kitchen: state.kitchens[index],
                            onTap: () => event.setActiveIndex(index),
                            isSelected: state.activeIndex == index,
                          ),
                        ),
                      );
              },
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
