import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/infrastructure/models/data/stock.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';
import 'package:venderfoodyman/presentation/component/custom_checkbox.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class IngredientItem extends ConsumerWidget {
  final VoidCallback onTap;
  final VoidCallback add;
  final VoidCallback remove;
  final AddonData addon;

  const IngredientItem({
    required this.add,
    required this.remove,
    super.key,
    required this.onTap,
    required this.addon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.r),
        decoration: BoxDecoration(
            color: Style.white,
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCheckbox(
                  isActive: addon.active ?? false,
                  onTap: onTap,
                ),
                10.horizontalSpace,
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          addon.product?.translation?.title ?? "",
                          style: Style.interNormal(
                            size: 16,
                            color: Style.blackColor,
                          ),
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        "+${AppHelpers.numberFormat(addon.product?.stock?.totalPrice ?? 0)}",
                        style: Style.interNormal(
                          size: 14,
                          color: Style.black,
                        ),
                      )
                    ],
                  ),
                ),
                (addon.active ?? false)
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: remove,
                            icon: Icon(
                              Icons.remove,
                              color: (addon.quantity ?? 1) == 1
                                  ? Style.borderColor
                                  : Style.blackColor,
                            ),
                          ),
                          Text(
                            "${addon.quantity ?? 1}",
                            style: Style.interNormal(
                              size: 16.sp,
                            ),
                          ),
                          IconButton(
                            onPressed: add,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
            Divider(
              color: Style.greyColor.withOpacity(0.2),
            )
          ],
        ),
      ),
    );
  }
}
