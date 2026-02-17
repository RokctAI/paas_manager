import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodExtras extends ConsumerWidget {
  const FoodExtras({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsProvider);
    final cartState = ref.watch(orderCartProvider);
    final event = ref.read(productsProvider.notifier);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: state.typedExtras.isEmpty
            ? AppStyle.transparent
            : AppStyle.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 26),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.typedExtras.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final TypedExtra typedExtra = state.typedExtras[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index != 0) 36.verticalSpace,
              Text(
                typedExtra.title,
                style: AppStyle.interSemi(
                  size: 16,
                  color: AppStyle.blackColor,
                  letterSpacing: -0.5,
                ),
              ),
              6.verticalSpace,
              typedExtra.type == ExtrasType.text
                  ? TextExtras(
                      uiExtras: typedExtra.uiExtras,
                      groupIndex: typedExtra.groupIndex,
                      onUpdate: (uiExtra) => event.updateSelectedIndexes(
                        typedExtra.groupIndex,
                        uiExtra.index,
                        cartStocks: cartState.stocks,
                      ),
                    )
                  : typedExtra.type == ExtrasType.color
                  ? ColorExtras(
                      uiExtras: typedExtra.uiExtras,
                      groupIndex: typedExtra.groupIndex,
                      onUpdate: (uiExtra) => event.updateSelectedIndexes(
                        typedExtra.groupIndex,
                        uiExtra.index,
                        cartStocks: cartState.stocks,
                      ),
                    )
                  : typedExtra.type == ExtrasType.image
                  ? ImageExtras(
                      uiExtras: typedExtra.uiExtras,
                      groupIndex: typedExtra.groupIndex,
                      onUpdate: (uiExtra) => event.updateSelectedIndexes(
                        typedExtra.groupIndex,
                        uiExtra.index,
                        cartStocks: cartState.stocks,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
