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
import 'package:productivity_sdk/src/common/presentation/notes/note_view_model.dart';
import 'package:remixicon/remixicon.dart';

/// The notes list's card — `TaskCard`'s section-33 list language with the
/// task furniture removed.
///
/// NO CHECKBOX, AND THAT IS THE POINT OF A NOTE. A task is something to
/// finish; a note is something to keep. There is no done state, no
/// priority tint, no deadline and no run pill here, because a note has
/// none of them. What it keeps is a heading, two lines of the body and
/// the moment it last changed.
class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onDelete,
    this.selected = false,
  });

  final NoteViewModel note;

  /// Opens the note in the editor pane. Null makes the card inert, which
  /// is what a read-only host would want.
  final VoidCallback? onTap;

  /// Removes the note. Null hides the control entirely rather than
  /// drawing one that does nothing.
  final VoidCallback? onDelete;

  /// Lit while this note holds the editor plane.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final String preview = note.preview;
    final String updated = note.updatedLabel;
    return Material(
      color: AppStyle.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppStyle.cardFor(Theme.of(context).brightness),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: selected
                  ? AppStyle.primary
                  : AppStyle.subtleStrokeFor(Theme.of(context).brightness),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Remix.sticky_note_line,
                size: 18.r,
                color: AppStyle.secondaryInkFor(Theme.of(context).brightness),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      note.displayTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.interSemi(
                        size: 13,
                        color: AppStyle.inkFor(Theme.of(context).brightness),
                      ),
                    ),
                    if (preview.isNotEmpty) ...[
                      4.verticalSpace,
                      Text(
                        preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.interNormal(
                          size: 12,
                          color: AppStyle.secondaryInkFor(
                            Theme.of(context).brightness,
                          ),
                        ),
                      ),
                    ],
                    if (updated.isNotEmpty) ...[
                      6.verticalSpace,
                      Text(
                        updated,
                        style: AppStyle.interNormal(
                          size: 11,
                          color: AppStyle.faintFor(
                            Theme.of(context).brightness,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton(
                  onPressed: onDelete,
                  tooltip: 'Delete note',
                  iconSize: 18.r,
                  color: AppStyle.faintFor(Theme.of(context).brightness),
                  icon: const Icon(Remix.delete_bin_line),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
