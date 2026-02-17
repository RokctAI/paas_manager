import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:venderfoodyman/presentation/styles/style.dart';
import 'stocks/create_food_stocks_body.dart';
import '../../../../component/components.dart';
import 'details/create_food_details_body.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class CreateProductModal extends ConsumerStatefulWidget {
  const CreateProductModal({super.key});

  @override
  ConsumerState<CreateProductModal> createState() => _CreateProductModalState();
}

class _CreateProductModalState extends ConsumerState<CreateProductModal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(createFoodDetailsProvider.notifier).updateAddFoodInfo(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalWrap(
      body: Column(
        children: [
          const ModalDrag(),
          IgnorePointer(
            child: Container(
              padding: REdgeInsets.all(6),
              height: 48.h,
              decoration: BoxDecoration(
                color: AppStyle.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppStyle.tabBarBorderColor),
              ),
              margin: REdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                onTap: (index) {},
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppStyle.blackColor,
                ),
                labelColor: AppStyle.white,
                unselectedLabelColor: AppStyle.textColor,
                unselectedLabelStyle: AppStyle.interRegular(size: 14),
                labelStyle: AppStyle.interSemi(size: 14),
                tabs: [
                  Tab(
                    child: Text(AppHelpers.getTranslation(TrKeys.addProduct)),
                  ),
                  Tab(child: Text(AppHelpers.getTranslation(TrKeys.stocks))),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CreateFoodDetailsBody(
                  onSave: () => _tabController.animateTo(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  ),
                ),
                const CreateFoodStocksBody(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
