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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/user_item.dart';
import 'widgets/create_user_modal.dart';
import 'package:venderfoodyman/presentation/styles/style.dart';
import '../../../../../component/components.dart';
import 'package:venderfoodyman/application/providers.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

@RoutePage()
class SelectUserPage extends ConsumerStatefulWidget {
  const SelectUserPage({super.key});

  @override
  ConsumerState<SelectUserPage> createState() => _SelectUserPageState();
}

class _SelectUserPageState extends ConsumerState<SelectUserPage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(orderUserProvider.notifier)
          .initialFetchUsers(refreshController: _refreshController),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDisable(
      child: Scaffold(
        backgroundColor: Style.greyColor,
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(orderUserProvider);
            final event = ref.read(orderUserProvider.notifier);
            return Column(
              children: [
                CustomAppBar(
                  bottomPadding: 4.h,
                  child: SearchTextField(
                    onChanged: (value) => event.setQuery(
                      refreshController: _refreshController,
                      text: value,
                    ),
                  ),
                ),
                state.isLoading
                    ? Center(
                        child: Container(
                          margin: REdgeInsets.only(top: 30),
                          width: 30.r,
                          height: 30.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.r,
                            color: Style.blackColor,
                          ),
                        ),
                      )
                    : Expanded(
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullUp: true,
                          onRefresh: () => event.refreshUsers(
                            refreshController: _refreshController,
                          ),
                          onLoading: () => event.fetchMoreUsers(
                            refreshController: _refreshController,
                          ),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.users.length,
                            shrinkWrap: true,
                            padding: REdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 20,
                              bottom: 80,
                            ),
                            itemBuilder: (context, index) => UserItem(
                              user: state.users[index],
                              isSelected: index == state.selectedIndex,
                              onTap: () {
                                event.setSelectedUser(index);
                                context.maybePop(state.users[index].phone);
                              },
                            ),
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: REdgeInsets.all(16),
          child: Row(
            children: [
              const PopButton(heroTag: AppConstants.heroTagAddOrderButton),
              8.horizontalSpace,
              Expanded(
                child: CustomButton(
                  title: AppHelpers.getTranslation(TrKeys.addUser),
                  onPressed: () => AppHelpers.showCustomModalBottomSheet(
                    context: context,
                    modal: const CreateUserModal(),
                    isDarkMode: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
