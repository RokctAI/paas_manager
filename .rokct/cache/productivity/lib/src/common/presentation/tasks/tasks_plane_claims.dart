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

import 'package:base_sdk/src/presentation/adaptive/planes.dart';

/// The /tasks workspace's plane claims — design strip frame 44a,
/// "/tasks DECLARES 2 — HUB YIELDS TO 1", and frame 47a, "46's mechanism,
/// unchanged — no new plane".
///
/// 44a draws the workspace as TWO planes side by side: the task list in
/// one and the task detail (829), the compose lane (830, frame 44b) or a
/// guided run (sections 46 and 47) in the other, with the hub that pushed
/// the page compressed into the plane before them. The claims below are
/// what the installed pages declare on base_sdk's `PlaneHost`; they live
/// here so this package's tests can pin the allocation they produce.
abstract final class TasksPlaneClaims {
  /// The list. ONE plane while a pane is open beside it — 44a's list is a
  /// single column of cards, never a stretched one — and a second plane
  /// only when it would otherwise stand empty, so the list at rest still
  /// fills the stage the way it always has. A growing claim never
  /// displaces the pane: it is granted out of the leftover, never taken.
  static const PlaneSpan list = PlaneSpan.twoIfSpare;

  /// The detail, compose or run pane, and the objective picker (834):
  /// the default one-plane claim, landing in the LAST plane. Newest wins,
  /// so the picker slides list + detail one plane towards the start
  /// (frame 44c).
  static const PlaneSpan pane = PlaneSpan.one;

  /// The standalone `/tasks/run` page's claim (frame 46f, the one-plane
  /// push). One, never two: on any wider window that route hands the
  /// window to the workspace with the run in 44a's detail plane instead,
  /// so a run never holds planes of its own.
  static const PlaneSpan run = PlaneSpan.one;
}
