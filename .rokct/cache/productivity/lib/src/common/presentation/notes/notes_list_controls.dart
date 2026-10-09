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

/// What the /tasks list plane is showing: the tasks, or the notes.
///
/// TWO LISTS ON ONE PAGE, NOT TWO PAGES. Ray: "i cant do notes its only
/// tasks and no seperate notes if need to be" — a note wanted somewhere,
/// not a second route to go and find. The workspace keeps its planes, its
/// compose pane and its back pill; the segment below chooses which list
/// the first plane draws.
enum WorkspaceList { tasks, notes }

/// The Tasks / Notes segment, at the head of the list plane.
///
/// DELIBERATELY CHIP 827's CONTROL, NOT A TabBar. The page already states
/// a two-way-or-three-way choice as a lit segment — the sort segment and
/// the status tabs both — and a TabBar would bring its own controller, its
/// own animation and a second navigation idiom onto a page whose
/// navigation is PlaneHost's. Same height, same tokens, same lit-active
/// rule as `TaskSortSegment`, with a count beside each label because the
/// list header's count pill can only speak for the list it is over.
class WorkspaceListSegment extends StatelessWidget {
  const WorkspaceListSegment({
    super.key,
    required this.active,
    required this.counts,
    required this.onChanged,
  });

  final WorkspaceList active;

  /// How many rows each list holds, derived by the caller from the lists
  /// themselves — there is no count field to read.
  final Map<WorkspaceList, int> counts;

  final ValueChanged<WorkspaceList> onChanged;

  static const Map<WorkspaceList, String> _labels = <WorkspaceList, String>{
    WorkspaceList.tasks: 'Tasks',
    WorkspaceList.notes: 'Notes',
  };

  static String labelFor(WorkspaceList list) => _labels[list]!;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        color: AppStyle.cardAltFor(Theme.of(context).brightness),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppStyle.subtleStrokeFor(Theme.of(context).brightness),
        ),
      ),
      padding: EdgeInsets.all(2.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final WorkspaceList list in WorkspaceList.values)
            _segment(context, list),
        ],
      ),
    );
  }

  Widget _segment(BuildContext context, WorkspaceList list) {
    final bool isActive = list == active;
    final int count = counts[list] ?? 0;
    return GestureDetector(
      key: ValueKey<String>('workspace-list-${list.name}'),
      onTap: () => onChanged(list),
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isActive ? AppStyle.primary : AppStyle.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              _labels[list]!,
              style: AppStyle.interSemi(
                size: 11,
                color: isActive
                    ? AppStyle.blackColor
                    : AppStyle.secondaryInkFor(Theme.of(context).brightness),
              ),
            ),
            6.horizontalSpace,
            Text(
              '$count',
              style: AppStyle.interNormal(
                size: 11,
                color: isActive
                    ? AppStyle.blackColor
                    : AppStyle.faintFor(Theme.of(context).brightness),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The list plane's top line: the Tasks / Notes segment, and the header
/// utilities beside it.
///
/// Ray: "calendar and export should be n the top line where task and
/// notes rectangle". The utilities used to sit on the list header's second
/// line, and only on the tasks half, which left the notes half with no
/// way to back up at all. They now share the segment's line on BOTH lists
/// and act on whichever list is lit.
///
/// FITS A 360dp PHONE. The segment keeps its natural width and only
/// scales down - never overflows - when the line is narrower than the
/// segment plus the actions it carries; the actions are never dropped.
class WorkspaceListBar extends StatelessWidget {
  const WorkspaceListBar({
    super.key,
    required this.segment,
    this.actions = const <Widget>[],
  });

  /// The [WorkspaceListSegment].
  final Widget segment;

  /// The header utilities, in reading order, at the line's end.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: segment,
            ),
          ),
        ),
        ...actions,
      ],
    );
  }
}
