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
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:manager/domain/interface/notification.dart';
import 'package:manager/infrastructure/models/models.dart';
import 'package:manager/infrastructure/services/services.dart';

import 'notification_state.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationInterface _notificationRepository;

  int _notificationPage = 0;

  NotificationNotifier(this._notificationRepository)
      : super(const NotificationState());

  Future<void> fetchAllNotifications(BuildContext context) async {
    state = state.copyWith(isAllNotificationsLoading: true);

    final response = await _notificationRepository.getNotifications();
    response.when(
      success: (data) {
        state = state.copyWith(
            isAllNotificationsLoading: false, notifications: data.data ?? []);
      },
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, text: failure);
      },
    );
  }

  Future<void> fetchNotificationsPaginate(
      {VoidCallback? checkYourNetwork,
      RefreshController? refreshController,
      bool isRefresh = false}) async {
    final connected = await AppConnectivity.connectivity();
    if (isRefresh) {
      _notificationPage = 0;
    }
    if (connected) {
      final response = await _notificationRepository.getNotifications(
        page: ++_notificationPage,
      );
      response.when(
        success: (data) async {
          final List<NotificationModel> newList =
              List.from(state.notifications);
          newList.addAll(data.data ?? []);
          state = state.copyWith(
            notifications: isRefresh ? (data.data ?? []) : newList,
          );
          if (data.data?.isEmpty ?? true) {
            refreshController?.loadNoData();
          }
          if (isRefresh) {
            refreshController?.refreshCompleted();
          } else {
            refreshController?.loadComplete();
          }
        },
        failure: (failure, s) {
          debugPrint('==> get notifications more failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> readAll(BuildContext context) async {
    List<NotificationModel> notif = List.from(state.notifications);
    for (var i = 0; i < notif.length; i++) {
      if (notif[i].readAt == null) {
        notif[i] = notif[i].copyWith(readAt: DateTime.now());
      }
    }
    state = state.copyWith(
      notifications: notif,
      countOfNotifications:
          state.countOfNotifications?.copyWith(notification: 0),
    );

    final response = await _notificationRepository.readAll();
    response.when(
      success: (data) {},
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, text: failure);
      },
    );
  }

  Future<void> readOne(BuildContext context,
      {int? id, required int index}) async {
    List<NotificationModel> notif = List.from(state.notifications);
    notif[index] = notif[index].copyWith(
      readAt: DateTime.now(),
    );
    final notification = state.countOfNotifications?.copyWith(
        notification: (state.countOfNotifications?.notification ?? 0) - 1);
    state = state.copyWith(
        notifications: notif, countOfNotifications: notification);
    final response = await _notificationRepository.readOne(id: id);
    response.when(
      success: (data) {},
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, text: failure);
      },
    );
  }

  Future<void> fetchCount(BuildContext context) async {
    final response = await _notificationRepository.getCount();
    response.when(
      success: (data) {
        state = state.copyWith(countOfNotifications: data);
      },
      failure: (failure, s) {
        AppHelpers.showCheckTopSnackBar(context, text: failure);
      },
    );
  }
}
