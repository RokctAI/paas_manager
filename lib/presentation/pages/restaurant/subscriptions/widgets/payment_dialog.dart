import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:venderfoodyman/application/subscriptions/subscriptions_provider.dart';
import 'package:venderfoodyman/infrastructure/services/app_helpers.dart';
import 'package:venderfoodyman/infrastructure/services/local_storage.dart';
import 'package:venderfoodyman/infrastructure/services/tr_keys.dart';
import 'package:venderfoodyman/presentation/component/buttons/custom_button.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';

class PaymentDialog extends ConsumerWidget {
  const PaymentDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(subscriptionProvider);
    final notifier = ref.read(subscriptionProvider.notifier);
    final isLrt = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLrt ? TextDirection.ltr : TextDirection.rtl,
      child: SizedBox(
        height: (state.payments?.length ?? 0) > 8
            ? MediaQuery.sizeOf(context).height / 1.6
            : MediaQuery.sizeOf(context).height / 2,
        width: MediaQuery.sizeOf(context).width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppHelpers.getTranslation(TrKeys.selectPayment)),
            Expanded(
              child: ListView.builder(
                padding: REdgeInsets.symmetric(vertical: 12),
                itemCount: (state.payments?.length ?? 0),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => notifier.selectPayment(index: index),
                    child: Column(
                      children: [
                        8.verticalSpace,
                        Row(
                          children: [
                            8.horizontalSpace,
                            Icon(
                              state.selectPayment == index
                                  ? FlutterRemix.checkbox_circle_fill
                                  : FlutterRemix.checkbox_blank_circle_line,
                              color: state.selectPayment == index
                                  ? AppStyle.primary
                                  : AppStyle.black,
                            ),
                            10.horizontalSpace,
                            Text(
                              state.payments?[index].tag ?? "",
                              style: AppStyle.interNormal(size: 14),
                            ),
                          ],
                        ),
                        const Divider(),
                        8.verticalSpace,
                      ],
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              isLoading: state.isPaymentLoading,
              title: TrKeys.payment,
              onPressed: () {
                notifier.payment(
                  context,
                  onSuccess: () {
                    notifier.fetchSubscriptions(
                      isRefresh: true,
                      context: context,
                    );
                    // ref.read(shopProvider.notifier).fetchMyShop();
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
