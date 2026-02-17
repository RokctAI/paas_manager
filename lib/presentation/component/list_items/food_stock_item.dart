import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../component/components.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class FoodStockItem extends StatelessWidget {
  final Stock? product;
  final Function() onDelete;

  const FoodStockItem({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStyle.white,
      margin: REdgeInsets.only(bottom: 1),
      padding: REdgeInsets.symmetric(vertical: 12),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.12,
          motion: const ScrollMotion(),
          children: [
            Expanded(
              child: Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Slidable.of(context)?.close();
                      onDelete();
                    },
                    child: Container(
                      width: 50.r,
                      height: 78.r,
                      decoration: BoxDecoration(
                        color: AppStyle.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          bottomLeft: Radius.circular(16.r),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        FlutterRemix.close_fill,
                        color: AppStyle.white,
                        size: 24.r,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            if ((product?.quantity ?? 0) > 0)
              Container(
                width: 50.r,
                height: 78.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                  color: AppStyle.primary,
                ),
                child: Text(
                  '${(product?.quantity ?? 1) * (product?.stock?.product?.interval ?? 1)} ${product?.stock?.product?.unit?.translation?.title ?? ""}',
                  style: AppStyle.interSemi(size: 15),
                ),
              ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.stock?.product?.translation?.title ?? '',
                    style: AppStyle.interNormal(
                      size: 14,
                      color: AppStyle.black,
                      letterSpacing: -0.3,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    product?.stock?.product?.translation?.description ?? '',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.interNormal(
                      size: 12,
                      color: AppStyle.textColor,
                      letterSpacing: -0.3,
                    ),
                  ),
                  ...?product?.stock?.extras?.map(
                    (e) => Padding(
                      padding: REdgeInsets.only(right: 4, top: 4),
                      child: Row(
                        children: [
                          Text(
                            "${e.group?.translation?.title ?? ''}: ",
                            style: AppStyle.interNormal(
                              size: 12,
                              color: AppStyle.textColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            AppHelpers.getTranslation(e.value ?? ''),
                            style: AppStyle.interNormal(
                              size: 12,
                              color: AppStyle.black,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...?product?.addons?.map(
                    (e) => Padding(
                      padding: REdgeInsets.only(right: 4, top: 4),
                      child: Row(
                        children: [
                          Text(
                            e.product?.translation?.title ?? '',
                            style: AppStyle.interNormal(
                              size: 12,
                              color: AppStyle.textColor,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            "  ${AppHelpers.numberFormat((e.totalPrice ?? 0) / (e.quantity ?? 1))} x ${e.quantity ?? 1}",
                            style: AppStyle.interNormal(
                              size: 12,
                              color: AppStyle.black,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  if (product?.shopBonus ?? false)
                    Text(
                      AppHelpers.getTranslation(TrKeys.shopBonus),
                      style: AppStyle.interSemi(
                        size: 14,
                        color: AppStyle.black,
                        letterSpacing: -0.3,
                      ),
                    )
                  else if (product?.bonus ?? false)
                    Text(
                      AppHelpers.getTranslation(TrKeys.bonus),
                      style: AppStyle.interSemi(
                        size: 14,
                        color: AppStyle.black,
                        letterSpacing: -0.3,
                      ),
                    )
                  else
                    Text(
                      AppHelpers.numberFormat(product?.totalPrice),
                      style: AppStyle.interSemi(
                        size: 14,
                        color: AppStyle.black,
                        letterSpacing: -0.3,
                      ),
                    ),
                ],
              ),
            ),
            8.horizontalSpace,
            CommonImage(
              width: 110,
              height: 106,
              url: product?.stock?.product?.img,
              radius: 0,
              errorRadius: 0,
              fit: BoxFit.fitWidth,
            ),
            16.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
