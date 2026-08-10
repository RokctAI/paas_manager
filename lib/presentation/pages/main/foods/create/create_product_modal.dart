// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
  const CreateProductModal({super.key}) ;

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
                color: Style.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Style.tabBarBorderColor),
              ),
              margin: REdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                onTap: (index) {},
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Style.blackColor,
                ),
                labelColor: Style.white,
                unselectedLabelColor: Style.textColor,
                unselectedLabelStyle: Style.interRegular(size: 14.sp),
                labelStyle: Style.interSemi(size: 14.sp),
                tabs: [
                  Tab(
                    child: Text(AppHelpers.getTranslation(TrKeys.addProduct)),
                  ),
                  Tab(
                    child: Text(AppHelpers.getTranslation(TrKeys.stocks)),
                  ),
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
