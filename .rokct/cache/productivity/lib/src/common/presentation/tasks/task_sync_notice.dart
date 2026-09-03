// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The ONE line the tasks page may say about a failed pull.
///
/// It is drawn only when both facts hold: the local list is empty AND the
/// last pull failed. An empty list with a healthy sync is just an empty
/// list; a list with rows in it is the answer already, and a banner over
/// it would be noise about a backend the user did not ask about. Either
/// way the widget is exactly nothing.
///
/// It takes two booleans and no failure object on purpose: there is no
/// path by which a cmd name, an error class or any error text can reach
/// the screen through it.
class TaskSyncNotice extends StatelessWidget {
  const TaskSyncNotice({
    super.key,
    required this.localListEmpty,
    required this.lastPullFailed,
  });

  /// Student-facing, and deliberately free of any admin detail.
  static const String message =
      'Sync paused. '
      'Your tasks will sync when the connection is back.';

  /// Whether the LOCAL list is empty — the store's answer, not the
  /// filtered view's. A filter that hides every row is not an empty list.
  final bool localListEmpty;

  /// Whether the last pull failed (`TaskPullService.syncFailed`).
  final bool lastPullFailed;

  @override
  Widget build(BuildContext context) {
    if (!localListEmpty || !lastPullFailed) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 8.h, left: 24.w, right: 24.w),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppStyle.interNormal(size: 12, color: AppStyle.textDarkFaint),
      ),
    );
  }
}
