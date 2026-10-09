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

import 'package:base_sdk/base_sdk.dart';
import 'package:flutter/material.dart';

import 'package:productivity_sdk/src/common/presentation/notes/notes_list_controls.dart';
import 'package:remixicon/remixicon.dart';

/// THE PRODUCTIVITY PLUS, ON THE FLOATING NAV.
///
/// Ray, 2026-09-20: "i think productivity plus should be in the floating nav
/// when you in its page. floating nav already accept modes and buttons".
///
/// NOTHING NEW IS DRAWN. The bar is base_sdk's own [FloatingBottomNav] in
/// [FloatingNavControlsMode] with no [FloatingNavControlsMode.input] - which
/// is the mode's documented "pill of round buttons" shape - and the plus is
/// one [FloatingNavAction] in [FloatingNavControlsMode.leadingActions], the
/// slot whose own doc names this exact case: "any other SDK's primary action
/// - a tasks app's 'new task'". So the mechanism Ray points at is the
/// mechanism used, and the page stops carrying a control of its own.
///
/// WHAT IT REPLACES, precisely: the `FloatingActionButton` the /tasks list
/// plane parked in its `Scaffold.floatingActionButton`, wrapped in a
/// `GestureDetector` because a FAB has no long press. One plus per screen -
/// the same rule the bar's back segment already keeps for back - so the FAB
/// is gone rather than duplicated.
///
/// THE LONG PRESS COMES WITH IT. "plus opens new but i think hlding it
/// should give me option like tasks notes" (Ray) is [onChooseList], and it
/// rides [FloatingNavAction.onLongPress] - the bar's controls have always had
/// a long press, and base_sdk now offers it to callers, so the shortcut is
/// not lost in the move.
///
/// THE PLUS WEARS THE BAR'S RESTING CONTROL LOOK, not a brand fill: a
/// [FloatingNavAction] with `active: false`, which is what the reference
/// composer's leading "+" is. `active` is the mode's "this thing is ON"
/// language (mic live, camera on) and a new-item button is not a toggle, so
/// claiming it would say something untrue. No colour is chosen here at all -
/// the bar paints its own controls.
class ProductivityPlusNav extends StatelessWidget {
  /// Key the tests and a guided tour use to find the bar.
  static const Key navKey = ValueKey<String>('productivity-plus-nav');

  /// The glyph the plus wears - the same `Remix.add_line` the button it replaces
  /// wore, named so a test can find it without depending on a label the bar
  /// does not print.
  static const IconData plusIcon = Remix.add_line;

  /// Which list the plus makes an item of right now. Drives the accessible
  /// label and the tooltip only: the bar prints no text under its controls.
  final WorkspaceList list;

  /// A tap - open a new item of [list]. The one gesture that never asks a
  /// question.
  final VoidCallback onNew;

  /// A long press - name both lists and open the chosen one. Null leaves the
  /// plus with a tap and nothing else.
  final VoidCallback? onChooseList;

  const ProductivityPlusNav({
    super.key,
    required this.list,
    required this.onNew,
    this.onChooseList,
  });

  /// THE LABEL IS TRANSLATED, because it is painted on the bar: the
  /// accessibility label `Semantics(label:)` reads out and the long-press
  /// `Tooltip(message:)` shows are both this string
  /// (base_sdk `floating_bottom_nav.dart`), `FloatingNavAction.label` is
  /// documented "already translated by the caller - base_sdk owns no copy",
  /// and `adaptive_bar.md` is absolute about it: "No hardcoded user-facing
  /// strings, INCLUDING ACCESSIBILITY LABELS" (§8), every string "routed
  /// through `TrKeys` + `AppHelpers.getTranslation`" (§7 item 6).
  ///
  /// PLAIN KEY LITERALS, not `TrKeys` members, because productivity_sdk owns
  /// this copy and base_sdk declares none of it - the same shape launch_sdk's
  /// `LauncherAppItem` uses for `use_as_phone`, and the shape this SDK's
  /// `manifest.json` `tr_keys` already publishes for the composer to inject.
  /// This SDK's own lib cannot read the injected `TrKeys.<name>` (its tests
  /// run on a bare checkout), so it asks for the key by its value.
  ///
  /// ENGLISH IS UNCHANGED. With no row served for either key,
  /// `AppHelpers.getTranslation` falls through `AppHelpers.humanizeTrKey`,
  /// which turns the underscore into a space and upper-cases the first
  /// character - rendering these two as exactly "New task" and "New note",
  /// the sheet's own words. So the button and the sheet it opens still
  /// cannot drift apart, and every other locale can now be served.
  static const String newTaskKey = 'new_task';
  static const String newNoteKey = 'new_note';

  /// Which key [list] asks for.
  static String labelKeyFor(WorkspaceList list) => switch (list) {
    WorkspaceList.tasks => newTaskKey,
    WorkspaceList.notes => newNoteKey,
  };

  /// What the plus makes, translated.
  String get label => AppHelpers.getTranslation(labelKeyFor(list));

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: navKey,
      child: FloatingBottomNav(
        mode: FloatingNavControlsMode(
          // Nothing trails the plus. The page has one primary action and no
          // toggles, and an empty trailing list is what leaves the pill the
          // single round button this page needs.
          actions: const <FloatingNavAction>[],
          leadingActions: <FloatingNavAction>[
            FloatingNavAction(
              icon: plusIcon,
              label: label,
              onTap: onNew,
              onLongPress: onChooseList,
            ),
          ],
        ),
      ),
    );
  }
}
