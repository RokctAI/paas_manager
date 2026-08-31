## 1.0.4

* Design strip section 44 — **the /tasks workspace**, frames **44a**
  (list · detail), **44b** (the compose lane), **44d** (the phone fold)
  and **44e** (calendar mode). The page was BUILT and the screen was
  never designed; section 7e settled its door and explicitly deferred
  what lies behind it. This is that design pass.
  * **The plane claim, and the fork this closes.** Frame 44a's stamp
    reads "/tasks DECLARES 2 — HUB YIELDS TO 1", while section 7e had
    drawn /tasks landing in the bare trailing plane — a claim of one.
    The frame calls that "a choice, not a defect" and asks for it to be
    made explicitly rather than inherited. **Two is picked**, on 44a's
    stamp, and expressed through base_sdk's shipped `ListPlaneFlow`
    (`listSpan: PlaneSpan.two`) — the section-38 list flow, whose corner
    back pill (canonical 347) is raised only while a pane is open.
  * **44b is the reason the claim matters.** The shipped page built the
    whole compose form as an inline block **wedged above the list** —
    five `Expanded` rows of chips and dropdowns competing with the list
    for the same column. It now takes the LAST plane, so the list keeps
    its planes and stays legible while you type. No field is added and
    none is removed; create and edit stay ONE component with an empty
    model, exactly as the shipped page already treated them.
  * **825** `TaskCard` — the section-33 list card: 19px round checkbox,
    title struck through when done, the meta chip run (priority flag
    tinted red/amber/blue, deadline in the shipped
    `DateFormat('MMM dd, hh:mm a')`, category, recurrence, reminder
    bell), then the subtask progress. **That progress is DERIVED from
    the list and never read** — there is no progress field anywhere, the
    same honesty rule section 41 used for mastery goals.
  * **826** `SubtaskCheckLine` — deliberately the same shape as 41c's
    ToDo check line, so a task's subtasks and a mastery goal's todos
    read alike.
  * **827** `TaskSortSegment` — Created / Deadline / Priority as a 30px
    three-way segment. Promoted from the shipped `DropdownButton`
    because there are only three values and a dropdown hid two of them
    behind a tap.
  * **828** `LocalOnlyStrip` — flag (a), stated on the screen for the
    first time: these tasks live on this device only, no remote store,
    no sync. It names `TasksTable` and `TodoRepositoryImpl` in code type
    so a reader can go and check, sits above the first card at EVERY
    width including the phone, and is **not dismissible and not a
    warning tint** — the fact does not change between sessions.
  * **831** `SubtaskComposerRow` — dashed 44px row; dashed means nothing
    committed yet, the rule frame 43a used for the driver row.
  * **canonical 700 / 362 / 363** `TaskListHeader` and `TaskStatusTabs`
    — header with count pill, and All / Pending / Completed as
    colour-coded tabs carrying their own counts, re-dressing the shipped
    `ChoiceChip` row. Every count is derived from the same list the tabs
    filter.
  * **44d, the fold** — on one plane the detail pane has no phone form
    of its own: the card **expands in place**, keeping the shipped
    `ExpansionTile` behaviour, so the subtask check lines still reach
    the phone rather than becoming a second push. The expansion IS the
    fold.
  * **44e, calendar mode** — the shipped `TableCalendar` re-dressed in
    base tokens: today ringed in primary, the selected day filled
    primary, and a primary dot under any day a local task's `deadline`
    lands on. A mode of the list plane, not a screen.
* **Two flags ride the screen and are drawn rather than hidden.**
  `recurrence` is stored and **nothing ever acts on it** — no scheduler,
  no rollover, no next-instance creation anywhere in the SDK, so a task
  marked Daily is a label; the REPEATS quad is drawn because the field
  is real, and "None" is deliberately never drawn as a repeat chip.
  Reminders are **local notifications only**, and the toggle's sub-line
  says exactly that.
* **Nothing behavioural changed.** `_saveTask`, `_startEditing`,
  `_cancelEditing`, `_toggleTodo`, `_removeTodo`, `_addSubtask`,
  `_toggleSubtaskStatus`, `_toggleFormSubtaskStatus`, `_handleRecurrence`,
  `_pickDeadline`, `_exportData` and `_getFilteredAndSortedTodos` are
  the shipped implementations, untouched. What changed is where things
  are drawn.
* **Superseded but NOT deleted:** `_sortOptions` and `_getPriorityColor`
  fed the shipped dropdown and card tint and are now unreferenced. They
  are left in place with a note — nothing in this pass was asked to
  remove shipped code.
* **Testing.** The components live in `lib/` rather than in the template
  and take no host wiring — their imports are base_sdk, Flutter and the
  two leaf packages `flutter_screenutil` and `intl`, all four of them
  now declared in this package's `pubspec.yaml` (they had been resolving
  only transitively through base_sdk). That is what makes them testable:
  a widget test constructs one directly with no app shell. This
  package's two existing test files **cannot load on a bare checkout**
  because `build_runner` is not a dev_dependency and drift's and
  freezed's generated sources are therefore absent. That is unchanged
  here and pre-existing. Suite goes **0 passing / 2 failing to load →
  28 passing / the same 2 failing to load**. The template itself was
  verified by composing it with `${package}` substituted and analyzing
  that, since `templates/**` is excluded from analysis fleet-wide.

## 1.0.2

* **Fix: deleted tasks came back on the next start.** Removing a task on
  /tasks dropped it from the in-memory list and then called `saveTodos`, which
  only inserts and updates - it has no delete. The row stayed in `TasksTable`,
  so the next `loadTodos` read it straight back and every task the user had
  ever deleted reappeared. Deletion is now its own repository operation,
  `deleteTodo(id)`, and `_removeTodo` calls it with the id of the task it just
  removed.
* **Deletion is an operation, not an inference.** The obvious alternative -
  having `saveTodos` prune any row absent from the list it was handed - was
  rejected because `TasksTable` has a second writer. `TaskService` inserts and
  updates rows the tasks surface never sees, and nothing on a row records
  which writer put it there: the `createdBy` column is only ever echoed back
  from a row that was already loaded, so it is null for both writers and
  cannot scope a prune. A prune-on-save would therefore have deleted
  `TaskService`'s rows whenever the tasks page saved. Naming the id keeps the
  write to the one row the user actually deleted, and is correct no matter how
  ownership of the table is settled later.
* **Both halves are pinned by tests** against a real drift/SQLite database: a
  deleted task is absent after a genuine save-and-reload cycle, and a delete
  issued by the tasks surface leaves `TaskService`'s rows intact and readable.

## 1.0.1

* **Fix: /tasks lost everything but the name and the checkbox on restart.**
  `TasksTable` stores a task's subtasks, notification id, reminder flag,
  priority, category and recurrence in its `data` JSON column - the typed
  columns hold none of them. `saveTodos` wrote that column correctly, but
  `loadTodos` handed the column back as a raw, still-encoded string and never
  decoded it, so every one of those fields was silently dropped the next time
  the page opened. `loadTodos` now decodes the blob and rebuilds the full map,
  with the typed columns staying authoritative for the fields they own.
* **Rows without a usable blob keep loading.** A `data` column that is null,
  empty, malformed, or holds valid JSON that is not an object degrades to "no
  extras" for that one row instead of throwing - a decode that threw would
  have turned a silent loss into a tasks page that will not open at all, and
  dev databases written before this fix hold exactly those rows.
* **Save path hardened alongside it.** The row id is resolved once and stored
  in the blob as well, so a task saved without an id comes back under the id
  its row actually has; the transient `data` key is stripped before encoding,
  so a reloaded task can no longer nest one encoding inside the next on every
  save; and a task holding a value json cannot encode now loses only its own
  extras instead of aborting the transaction and the write for every other
  task in the list.
