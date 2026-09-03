## 1.3.0

* **A failed task pull is no longer silent.** `TaskPullService.pull`
  used to catch every failure of the `api.projects.list_personal_tasks`
  pull and drop it, so a dead or uncomposed backend produced no
  telemetry and no visible state. Tasks stay local-first and the read
  path is untouched (`TodoRepositoryImpl` is not changed; `syncNow`
  still never throws and the page still kicks sync off unawaited) —
  what changed is that the failure is now observable:
  * **Telemetry.** Every failed pull emits one event on base_sdk's
    error lane (`TelemetryClient.I.logError`) with type
    `task_pull_failed` and a context of exactly two fields: `cmd`
    (the gateway cmd the pull was issued under) and `error_class`
    (`e.runtimeType.toString()`). Never the error text, which can
    carry a URL, a token or server-authored copy.
  * **A typed status.** `TaskPullService.lastFailure`
    (`ValueNotifier<TaskPullFailure?>`, plus the `syncFailed` getter)
    records the same cmd + error class and is cleared by the next
    pull that completes.
  * **One friendly line.** New `TaskSyncNotice` widget; the installed
    tasks page watches `lastFailure` and draws, in its empty state
    only, "Sync paused. Your tasks will sync when the connection is
    back." when the LOCAL list is empty and the last
    pull failed. A list with rows in it shows nothing new — no banner —
    and no cmd name, error class or error text ever reaches the screen.
* Version bumped past the open 1.2.0 (PR #33) so the two do not collide.

## 1.2.0

* Design strip **frame 44c — the M2 bridge**: linking a task to a
  strategic objective. Approved 2026-08-30; the amber NOT-IN-BACKEND
  flag the frame carried is now obsolete and is NOT drawn — both of
  its preconditions exist (`sync_personal_task` carries the link;
  tasks push through the outbox), so the link is real.
  * **834 the objective picker pane**, a 1-plane push that wins the
    last plane: header + count pill, the provenance note naming
    `get_strategic_objectives` / `get_pillars`, pillar filter tabs
    with counts (All pillars / one per pillar), the objective cards
    with a round radio, Cancel / Link objective at 2 : 3.
  * **787 the approved 41a objective card**, reused verbatim: title,
    pillar tag with its accent, KPI count — nothing added. The accent
    is DERIVED from the pillar's position in the pillar list (a pillar
    has no colour column) and the KPI count is DERIVED by counting
    `get_kpis`; there is no count field to read.
  * **833 the link row** in the task detail pane: what objective the
    task serves (pillar › title), and the door to the picker. A saved
    task is linked the moment Link objective is tapped; a task being
    composed keeps the link on the form until Save task, like every
    other field.
  * **`ObjectivesRepositoryFacade` / `ObjectivesRepositoryImpl`** over
    the productivity module's own read cmds through the platform
    gateway (`tenant.api.get_strategic_objectives` / `get_pillars` /
    `get_kpis`) — zero Dart callers before this. Read-only by
    construction: `commit_plan` is a destructive whole-plan replace
    and nothing in this SDK can reach it.
  * **`strategicObjective` on the task map** travels the way
    `stepsAreSequential` does — `TaskRequest` / `TaskResponse` and the
    existing `task.upsert` op — to Task's typed `strategic_objective`
    column (projects module, this release). Three wire states: absent
    is silence, `""` unlinks, a name links. A pull that unlinked wins
    over a stale local link; the handshake, which never carries the
    column, clears nothing. The title / pillar pair chip 833 reads is
    device bookkeeping beside the name and never goes to the wire.
  * The tasks page now builds the section-38 list flow as the
    `PlaneHost` stack `ListPlaneFlow` wraps, with the same page names
    and corner Back, because the picker is a THIRD step: list + detail
    slide left and the picker takes plane 3, as the frame draws.
* Design strip **frame 46i — the paused run on the hub's Tasks row**
  (approved 2026-08-30; 2026-08-31: 47j folds into it). Chip 859
  promoted to the hub row: ONE LINE on the existing Tasks row — not a
  new row, not a new group — naming which run is paused, which task it
  belongs to and where it stopped ("1 run paused · Month-end stock
  count, step 3 of 6", "kept from Thursday — resumes where it
  stopped"), and gone when no run is paused. Productivity half only.
  * **`PausedRunSummary`**, DERIVED from the task list through
    `TodoRepositoryFacade.loadTodos()` and `TaskRun.isInProgress` /
    `positionLabel`: no table, no flag anybody sets, most recently
    touched first. A paused maintenance run surfaces on identical
    terms to any other task.
  * **`pausedRunProvider`** (Riverpod, auto-disposed, the local store
    and nothing else) and **`PausedRunLine`** over it; loading and
    failure draw nothing. `PausedRunLineView` for a host or test that
    holds the derivation already.
  * **Two manifest integrations** for the merchants manager hub,
    declared exactly as the launcher glance is: the
    `// @productivity-tasks-row` marker (with its 8-space indent) takes
    the widget, `// @productivity-tasks-row-imports` at column 0 takes
    the import. The run opens by route path (`/tasks/run?task=<id>`)
    through `context.router`, so the hub never imports a page. The
    markers themselves are the COMMERCE side of the frame and are not
    in this release; until they land the composer reports the marker
    missing and skips the wiring.

## 1.1.0

* Design strip **section 46 — the guided run** (frames 46a, 46b, 46c,
  46f, 46g, 46i's badge) and the visible half of **section 47** (47k,
  47l, 47m, 47n). Both are GENERIC ON THE TASK: per the owner's ruling
  a maintenance run "is just a normal multi step task with reminder, it
  doesnt have any privilege", so there is no field, screen or string
  for any vertical anywhere in this release.
  * **The run is DERIVED state.** `TaskRun` (pure Dart, no store)
    reads a task's subtasks as steps: the current step is the first
    one not complete, a timed step's remaining time is
    `duration_seconds − (now − started_at)` recomputed on every read,
    and "finished" is every step done. Nothing is counted down in
    memory, so a run resumes after the app is killed with its
    wall-clock credit intact (ruling three). One `Timer.periodic` per
    page, alive only while a clock is running, asks for a repaint and
    nothing else. paas_pos's stage dialog — two timers per stage,
    ~2× fast, and an elapsed credit computed then discarded on resume —
    is deliberately NOT ported.
  * **Four generic step fields on a subtask** (server: `Task Subtask`
    in the projects module): `instruction` (shown under the active
    step's title), `durationSeconds` (0 = untimed, confirm-only — its
    Continue is live at once and it never auto-completes), `startedAt`
    (written once, never rewritten; no pause in v1) and `completedAt`.
    One flag on the task, `stepsAreSequential` (default false = the
    any-order checklist of today), gates the next step on the one
    before it. All travel through `TaskRequest` / `TaskResponse` and
    the existing `task.upsert` op; the server writes them through a
    meta-checked whitelist.
  * **Rulings rendered.** A blocked step cannot be skipped: the only
    block in the generic model is a clock, `TaskRun.complete` refuses
    while it runs, and chip 857 keeps Continue on screen, disabled,
    locked — never hidden — with the reason (856) naming the clock and
    the route out (858) honestly saying there is none but time; amber,
    never red. Abandoning keeps progress: Leave (866) writes nothing
    and `restart()` is the one destructive act, named Start over and
    tinted so on the resume card (860). Back (855) moves ONE step and
    keeps the reopened step's start.
  * **852 / 865** the step rail — "STEP 3 OF 9", "6 left", a
    three-state hairline, each done step with its outcome kept beside
    it; on one plane it folds to the compact rail (46f). **853** the
    step card, **872** its clock, **862** Skip for now — offered only
    on an any-order run, because a sequential run has no skip and a
    blocked step has none either. **859** the run badge on the task
    card, "Step 3 of 9" beside the derived progress, and a Run / Resume
    pill.
  * **Two hosts, one view.** On a wide window /tasks hosts
    `TaskRunView` in its detail plane (46a: "the run is 44a's detail
    plane, no new push"); at one plane the workspace pushes the new
    `/tasks/run?task=<id>` route (`TaskRunRoute`, template
    `task_run_page.dart`), which other SDKs may open by path without
    importing this one. Finishing a run does not tick the task by
    itself: the finished card offers "Mark task done", the route pops
    `true`, and the workspace acts on it.
  * **47k / 47l snooze**, wired to the shipped `snoozeReminder`:
    `TaskReminderRow` draws REMIND and DUE side by side (1061) with the
    invariant in words (1063) and the snooze control that counts itself
    (1060, `snoozeCount` is device bookkeeping); `showSnoozeSheet` offers
    three fixed offsets and a free pick with tomorrow morning
    pre-selected (1062) and hands back a reminder time and NOTHING else.
    The device-local notification moves with it. The deadline is not
    written anywhere on this path.
  * **47m the long-term band** (`LongTermBandHeader`, 1064): tasks with
    `isLongTerm` sit in a labelled band above the day's work, and the
    compose pane gains the toggle. The surfacing rule frame 47m
    proposed (recurrence ≠ None and cycle ≥ 7 days) awaits the owner's
    word and is NOT derived.
  * **47n the sync-state badge** (`TaskSyncBadge`, 1066 / 1067 / 1068
    plus the parked failure): derived by `taskSyncStateFor` from the
    two facts the device holds — a queued outbox op's status, and
    whether the row carries the server's id. There is no synced flag
    and none is invented; a pushed row's absence is the success signal.
    `TaskSyncQueue.statesFor` answers for the whole list in one query.
  * **The compose pane** lets a step carry an instruction and a
    duration in minutes (chip 831's composer grew two fields) and the
    task carry STEPS IN ORDER and LONG TERM. Editing an existing task
    now keeps the fields the form does not show (`remindAt`,
    `snoozeCount`, `stepsAreSequential`, the sync ids) instead of
    rebuilding the map from scratch; a rolled-over recurrence copies
    the procedure and clears the step timestamps
    (`TaskRunStep.freshCopy`). Nothing else about recurrence changed and
    no scheduling was added.
  * **Not built here, on purpose:** 46d / 46h first-run setup on the
    runner (onboarding_sdk, another repo), 46i's mid-run line on the
    hub's Tasks row (merchants_sdk, another repo — `TaskRun.isInProgress`
    and `positionLabel` are exported for it), 47d / 47e / 47h readings
    and setup gates and 47i's photo tile (the water thread's own
    doctypes, linked to Task by name; nothing of theirs lives on a
    subtask).
  * **Tests.** `test/task_run_test.dart` pins the derivation as plain
    Dart: current step, the sequential gate, remaining time from
    timestamps, resume after a kill, the confirm-only step, Back,
    Skip, Start over and the map round trip. `test/manifest_wiring_test.dart`
    pins the route declaration (the radio pattern).
    `test/task_section_47_test.dart` pins the snooze arithmetic, the
    sync-state derivation and the reminder row. The build environment
    had a Dart SDK but no Flutter toolchain: the pure run derivation
    and the models were analyzed and their tests executed, while the
    widget files and widget tests were parse-checked and read by hand.
    The PR body says so.

## 1.0.5

* **Task sync, client side.** The four personal-task endpoints landed
  server-side on 2026-08-31 (`projects/frappe/src/task_sync.py`) and
  nothing on the client called them; that commit said so itself. This is
  the wiring. The /tasks workspace now pushes to `sync_personal_task`
  and `delete_personal_task`, pulls from `list_personal_tasks`, and
  moves a reminder through `snooze_task_reminder`.
  * **IT IS ADDITIVE, AND THAT IS THE POINT.** The local store is still
    the source of truth for every read, and every write still lands in
    drift FIRST and returns. Not one user-facing path awaits a network
    round trip: a save queues an op on the SyncEngine outbox and asks
    the engine to drain WITHOUT waiting for it. There is no offline
    branch — the same code runs with a live backend and with none ever
    configured, and the only difference is how long an op sits in the
    outbox. A device that never reaches a server behaves exactly as it
    did before this change, and `test/task_sync_test.dart` pins that
    with no `HttpService` registered at all.
  * **The handshake is orders', copied rather than reinvented.** A task
    is born on the device with a locally minted `client_id`; that id
    travels with every push; the server upserts on it and hands back its
    real `name`, which lands on the local row. Retrying a create after a
    dropped connection therefore updates the same Task instead of making
    a second one — the same property `OrderCreateSyncHandler` relies on,
    reached the same way.
  * **`TasksTable` gains `client_id` and `remote_id`** (schema 15,
    `addColumn`). `client_id` is deliberately NOT the engine's
    `offline:<uuid>` temp-id convention: the engine rewrites those
    tokens inside pending payloads once it learns a mapping, which for a
    task would rewrite a queued upsert's key into the server's name and
    duplicate the task on the next push.
  * **Pushes coalesce.** The page saves the whole list on every action,
    so ops are queued with `enqueueOrReplace` keyed on `client_id` and
    only when the WIRE payload actually changed. Ten edits before the
    first successful push cost one outbox row carrying the latest
    snapshot.
  * **A pull never overwrites an unsent local edit.** A task with a
    queued op is skipped, because the device's copy is the newer one.
    Pulled tasks are merged onto the local row, so device-local
    bookkeeping the server does not carry (the notification id) survives.
  * **Snooze moves the reminder and NEVER the deadline.** The op carries
    no deadline field at all, the local write does not touch the
    `dueDate` column, and a response claiming `deadline_moved` is
    refused rather than applied.
  * **`TaskRequest` / `TaskResponse` rewritten** against the endpoints
    they were supposed to describe. They previously matched nothing:
    `TaskRequest` had no `clientId`, no `remindAt` and no subtasks.
    Absent fields are now OMITTED rather than sent as null, because the
    server reads a present key as an instruction and an absent one as
    silence.
  * **828 `LocalOnlyStrip` is REMOVED**, and only because it stopped
    being true. It said "no remote store, no sync"; there is now both.
    Nothing replaces it: a claim that these tasks ARE synced would be
    just as wrong for a host that composes this SDK without a backend.
    The flag it drew is struck from the page's own header comment rather
    than quietly dropped.
  * `ProductivitySdkDependencies.register` is now idempotent, matching
    every other SDK's hook — it threw on a second call.

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
