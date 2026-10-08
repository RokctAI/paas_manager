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

import 'package:productivity_sdk/src/common/presentation/notes/notes_list_controls.dart';
import 'package:remixicon/remixicon.dart';

/// The /tasks add button's long press — Ray, on the launcher's Tasks page:
/// "plus opens new but i think hlding it should give me option like tasks
/// notes".
///
/// A TAP IS UNCHANGED, AND THAT IS THE POINT. The add button still opens a
/// new item of whatever list the plane is drawing — a task on Tasks, a note
/// on Notes — because that is the one gesture that must never ask a
/// question. The long press is the shortcut for the other list: it names
/// both and opens whichever is chosen, so a note can be started from the
/// tasks list without first switching segments.
///
/// Reuses [WorkspaceList] rather than minting a second two-value enum: the
/// choice on offer here IS which of the page's two lists the new item joins,
/// and a parallel spelling of that is how the sheet and the segment would
/// come to disagree.
///
/// Resolves to the chosen list, or null when dismissed.
Future<WorkspaceList?> showNewItemSheet(BuildContext context) {
  return showModalBottomSheet<WorkspaceList>(
    context: context,
    backgroundColor: AppStyle.cardFor(Theme.of(context).brightness),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (BuildContext context) => const _NewItemSheet(),
  );
}

/// The key on each row, by list, so the host and this SDK's tests can reach
/// one choice without depending on the sheet's order.
Key newItemSheetKeyFor(WorkspaceList list) =>
    ValueKey<String>('new-item-${list.name}');

/// What each row says it makes. The label is the segment's own word for the
/// list, so the sheet and the segment cannot drift apart.
String newItemSheetLabelFor(WorkspaceList list) => switch (list) {
  WorkspaceList.tasks => 'New task',
  WorkspaceList.notes => 'New note',
};

class _NewItemSheet extends StatelessWidget {
  const _NewItemSheet();

  static const List<WorkspaceList> _order = <WorkspaceList>[
    WorkspaceList.tasks,
    WorkspaceList.notes,
  ];

  @override
  Widget build(BuildContext context) {
    // A BuildContext lookup for the mode, not the app-wide AppStyle.isDark
    // static (Ray, 2026-09-19: "glance doesnt change test immediately
    // untill you come back if you switched theme mode").
    //
    // This sheet is the page built by a [showModalBottomSheet] route, and a
    // route caches the page it built: the builder above runs once, when the
    // sheet opens, so an ancestor rebuild provably never reaches this
    // element — the same boundary a `const` child is. AppStyle's
    // mode-resolving statics are not an inherited widget either, so with
    // nothing else asked for the mode a flip made while the sheet is open
    // scheduled no rebuild of it and every row kept the previous mode's
    // fill, stroke and ink. Reading the inherited theme here makes this
    // element a dependent, so the flip itself restyles the open sheet, and
    // the mode is read ONCE here and handed to [_row] rather than each row
    // asking a static again.
    final Brightness brightness = Theme.of(context).brightness;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add to this page',
              style: AppStyle.interSemi(
                size: 16,
                color: AppStyle.inkFor(brightness),
              ),
            ),
            12.verticalSpace,
            for (final WorkspaceList list in _order)
              _row(context, list, brightness),
          ],
        ),
      ),
    );
  }

  /// One choice, in the snooze sheet's row language: a label, a caption and
  /// the whole row as the target.
  ///
  /// [brightness] is the mode the inherited theme reports, read once in
  /// [build]; every colour role here resolves against it rather than
  /// against AppStyle's app-wide flag.
  Widget _row(BuildContext context, WorkspaceList list, Brightness brightness) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        key: newItemSheetKeyFor(list),
        onTap: () => Navigator.of(context).pop(list),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppStyle.cardAltFor(brightness),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppStyle.subtleStrokeFor(brightness)),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                list == WorkspaceList.notes
                    ? Remix.sticky_note_line
                    : Remix.checkbox_circle_line,
                size: 16.r,
                color: AppStyle.secondaryInkFor(brightness),
              ),
              10.horizontalSpace,
              Expanded(
                child: Text(
                  newItemSheetLabelFor(list),
                  style: AppStyle.interSemi(
                    size: 13,
                    color: AppStyle.inkFor(brightness),
                  ),
                ),
              ),
              Text(
                WorkspaceListSegment.labelFor(list),
                style: AppStyle.interNormal(
                  size: 11,
                  color: AppStyle.faintFor(brightness),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
