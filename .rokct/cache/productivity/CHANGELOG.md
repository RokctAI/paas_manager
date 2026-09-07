## 1.5.2

* Tablet design audit 2026-09-07, defect 4: `/tasks` never showed frame
  44a's composition on a wide window, and the standalone run page claimed
  two planes where frame 47a rules "46's mechanism, unchanged — no new
  plane". Fixed at the pages and in the tour fragment; the phone is
  unchanged.
  * **The list is one plane wide beside its pane.** 44a draws the
    workspace as list | detail, each one plane; the list used to declare
    `PlaneSpan.two` and stretched a single column of cards across two
    planes whenever a detail, the compose lane or a run opened beside it
    on a three-plane window. The claims now live in `TasksPlaneClaims`
    (new, exported): the list is `twoIfSpare` — one plane beside a pane,
    a second only while the stage would otherwise stand empty, so the
    list at rest fills the window exactly as before — and every pane
    makes the default one-plane claim. Three planes with a pane open are
    list | pane | bare, two are list | pane, and the objective picker
    (44c) slides list + detail towards the start as drawn. The plane 44a
    gives the HUB is not this SDK's to draw: the manager hub is
    merchants' `RestaurantHubPlaneFlow`, a one-step host whose rows push
    real routes, so until it hosts `/tasks` inside its own flow (the
    commerce half of 44a, not built here) the plane it would keep trails
    bare at the end, the ruled place for a leftover.
  * **The fold test reads the plane COUNT.** `_isSinglePlane` compared
    the list's granted span, which is one beside a pane on a tablet too,
    so the list would have fallen into the phone fold (cards expanding in
    place, runs pushed as a route) the moment the claim changed; and from
    the page's own context — above its host — it always read one, so the
    run pill pushed the standalone route on every window. It now reads
    `Planes.count`, falling back to the window width by PlaneHost's own
    thresholds, exactly as `TaskRunView` derives it.
  * **Canonical 347 at the root of a wide window.** PlaneHost floats its
    pill only while the flow is deeper than its root, so `/tasks` with
    nothing open had no way back to the hub on a tablet. The page floats
    the same `FloatingBackPill` in the same bottom-END corner PlaneHost
    and calc's `CalculatorView` use, popping the route; the moment a pane
    opens PlaneHost's pill takes over, so there is one back per screen.
    One-plane windows keep their shipped navigation.
  * **`/tasks/run` yields a wide window to the workspace.** The route
    used to host `TaskRunView` on a `PlaneSpan.two` PlaneHost of its own,
    with no list beside it. On any window of two planes or more it now
    builds `TasksWorkspace(initialRunId: …)` — the `/tasks` page's body,
    split out of `TasksPage` so the route class keeps its argument-free
    const constructor (`const TasksRoute()` is what the hub pushes) — and
    the run opens in 44a's detail plane with the list beside it, the
    corner pill popping the pane and then the route. At one plane the
    page is what it was (46f), its claim now `PlaneSpan.one`, which is
    what it always received there. The workspace drops a run id the
    store does not hold. `TaskCard`s carry `ValueKey('task-card-<id>')`.
  * **Tour: the stills open what they show from the list.** The
    `productivity_tasks` step routed to `/tasks` with an empty store, so
    every wide still was "Nothing here yet." over two planes and a bare
    third. It now seeds four of a Limpopo water business's tasks through
    the page's own repository — deliveries, brine salt, an invoice, a
    long-term borehole (47m's band) — routes to `/tasks` and taps the
    first card: 44a's list | detail on a wide window, 44d's expanded card
    on the phone. The readings step now opens the softener run from its
    card's run pill instead of routing to `/tasks/run`: 47a's list | run
    on a wide window, the pushed page on the phone, then the same resume
    and readings as before. Captions are unchanged; nothing rendered
    names a demo.
* Tests: `test/tasks_planes_test.dart` pumps the workspace's stack on a
  real `PlaneHost` at 1066 and 800 logical and pins the allocation frame
  by frame — list | detail | bare and list | detail | picker at three
  planes, list | detail at two, the list grown to two planes at rest, the
  full step rail (not the fold's segments) inside a one-plane detail at
  three planes, and the standalone run's one-plane claim. The installed
  pages themselves are templates (analysis excludes them, and they import
  the composed app's comms_sdk), so the claims they declare are the
  thing under test.

## 1.5.1

* Two layout defects from the minilauncher Guided Tour (run 34040758271,
  stills 10 and 11, phone and tablet), fixed at the screens themselves;
  the tour fragment is unchanged.
  * **The compose lane clears the corner Back pill.** `PlaneHost` floats
    the pill (canonical 347) over the last plane's foot, and the new-task
    form scrolled under it — the Long term switch on the phone, Save task
    on the tablet. The form's list now sits inside a band reserved
    OUTSIDE the scroll, `PlaneBackClearance` (new, exported), sized by
    the pill's own figures — `planeBackClearance()` = the 60.r housing +
    PlaneHost's 16 bottom inset + the frames' 12.h gap, the same rule the
    merchants shell's `managerNavClearance` and zones'
    `driverRootNavClearance` follow — so no control can sit under the
    pill at ANY scroll offset. Padding inside the list (the previous
    88.h) only ever cleared it at the end of the scroll; the still is
    taken at the top. The pill itself is neither moved nor hidden.
  * **The readings step keeps its gate in sight while typing.** With the
    numeric keyboard raised the amber block (856, "Out of spec … Re-test,
    or record why") and the actions row scrolled off under it, so a
    locked Continue had no visible reason. While a reading or note field
    holds the focus, `TaskRunView` lifts the gate notice, the actions and
    Skip for now out of the step card and pins them at its foot, above
    the keyboard (`TaskRunView.pinnedFooterKey`); the moment focus leaves
    they return to the card and the layout is exactly what it was, at
    every width. Nothing is removed — Finish stays present and locked,
    never hidden (47h). The field being typed in is scrolled into view
    on focus (`Scrollable.ensureVisible`, both edges), and again once the
    pinned layout has laid out. The pin is read from focus, not from
    `MediaQuery.viewInsets`: a resizing Scaffold strips the bottom inset
    from its body. The pinned foot pads by the inset for a host that
    does not resize, and on a wide window by the Back pill's clearance,
    since /tasks floats the pill over the run pane.
* Tests: `test/compose_back_clearance_test.dart` pumps the compose frame
  inside a real `PlaneHost` with a real `FloatingBackPill` at 390x844 and
  1280x800 and sweeps every scroll offset for a control under the pill;
  `test/task_run_keyboard_test.dart` seeds the tour's own softener run
  (nine stages done, 175 / 212 / 8.4 / 1.9) under a 300-logical keyboard
  inset and pins the block, the actions and the focused field above it,
  then the foot's return to the card. All fail on the previous layout.

## 1.5.0

* Design strip **section 47 — the RO plant's service runs as ORDINARY
  TASKS** (frames 47a, 47b, 47c, 47d, 47h, 47i; approved by Ray
  2026-08-31: "maintenance is just a normal multi step task with
  reminder, no privilege"). Built on the section-46 runner as it stands:
  no maintenance screen, no dashboard, no hub row, no doctype, no plane
  of its own — a service run is a task made from a template, run in
  44a's detail plane (or the pushed `/tasks/run` page at one plane),
  and reminded of by the task's own reminder and recurrence. The water
  dashboard, tanks, efficiency and energy cards stay out (the
  2026-08-30 scope note).
  * **Step kinds on the runner** (`task_run.dart`): a step is `plain`
    (section 46's confirmation, with or without a clock), `reading` or
    `photo`, and may be `optional`. A reading step carries a list of
    `ReadingSpec`s — label, unit, min, max, or a calendar date — each
    with its recorded value; a photo step carries a path and a note. A
    new gate, `StepGate.incomplete`, is the block by DATA beside the
    block by TIME: a reading step cannot finish while a value is empty
    or out of spec, DERIVED from min / max on every read and never a
    flag. Skip on an optional step completes it as `skipped`; a required
    step has no Skip. `freshCopy` and Start over strip what was recorded
    and keep the spec. A plain step's map is byte-for-byte section 46's:
    the new keys are written only when they say something.
  * **47h — the readings step, REQUIRED** (`task_run_view.dart`): the
    values as fields with their spec beside them ("≤ 400", "6.0–10.0"),
    green in spec and amber out of it; while one is missing or out of
    spec the amber block (856) names the value in the frame's words —
    "TDS — permeate 212 ppm is outside ≤ 50 ppm" — and the route out
    (858) is the frame's too: "Re-test, or record why it is out of spec,
    to continue." A note explaining the value unlocks Finish; Finish
    stays present and locked until then, never hidden. What is typed is
    handed back through `onChanged` as it is typed, so a kill mid-entry
    loses nothing recorded.
  * **47i — the photo step, OPTIONAL**: the photo slot ("Add a photo —
    of the vessel head or the meter"), the note ("Anything worth
    remembering next time…"), and Skip (862) live beside a working
    Finish. The photo is a PATH STRING picked through base_sdk's
    `ImgService` (camera or gallery, the user's choice, base already
    carries `image_picker`); a host or test hands in its own picker via
    `TaskRunView.pickPhoto`. No preview is drawn and no file is read.
    The rail says "skipped", "recorded", "photo kept" beside such steps.
  * **47a — the templates** (`maintenance_templates.dart`): the softener
    regeneration (nine stages) and the megaChar backwash (seven, the
    first four shared), PORTED NOT INVENTED — paas_pos's `MaintenanceStage`
    order, its `AppConstants` durations in ONE map
    (`kMaintenanceStageSeconds`, 0 = confirm-only) and its operator
    instructions verbatim — then Readings (required) and Photo & notes
    (optional) as steps 10 and 11. The 11-value stage enum is not
    carried: a stage is a step title an owner can edit. A run is built
    as a task map: `stepsAreSequential`, Weekly recurrence (the 47a
    card's "every 7 days"), reminder on, due today. The 47a list's three
    replacement reminders (pre-filter 30 days, RO filter 180, membranes
    365) are ordinary tasks with a due date from the plant record and NO
    step list, because no source gives one.
  * **47b — the timed brine rinse** is a clock-gated step exactly as
    section 46 already gates one: 30 minutes, Continue locked with the
    remaining time named, no way past but time. **47c — coming back the
    next morning:** verified rather than built — remaining time was
    already derived from the persisted `startedAt`, so a stage started at
    22:00 reads as run out at 07:00 with no timer alive in between;
    pinned by test across a simulated overnight.
  * **47d — first-run plant setup on the same runner**
    (`maintenance_plant.dart`): "the plant has to be described before it
    can be serviced". The setup is itself a template — Vessels, Filters,
    RO membranes (required reading steps: counts with `min: 1`, install
    dates) and Water spec (optional, pre-filled with 47h's thresholds).
    A finished setup run is read back into a `PlantRecord` and kept on
    the device in base_sdk's LocalStorage host-record store
    (`productivity.plant`) by the hosts' run-save hook; the templates
    read it for due dates and for the readings' limits. Until it exists
    the compose lane offers the setup first and draws the service
    templates present but dimmed, with one line saying why.
  * **The entry point — "From template" in the compose lane (44b)**:
    one row of chips on a new task, keyed through this SDK's manifest
    `tr_keys` (`from_template`, `plant_setup`, `softener_maintenance`,
    `megachar_maintenance`, `pre_filter_replacement`,
    `ro_filter_replacement`, `ro_membrane_replacement`,
    `describe_the_plant_before_it_can_be_serviced`). Picking one fills
    the same form — title, steps, deadline, reminder, recurrence — and
    nothing is saved until Save task. The task map gains a `template`
    key naming what it was made from.
  * **Local-first, not on the wire.** The step kinds, specs, values,
    note and skipped flag live in the subtask map and so in the device's
    `TasksTable.data` blob. They are NOT sent: `task_sync.py`'s
    `SUBTASK_STEP_FIELDS` passthrough on the `Task Subtask` child
    doctype drops keys it does not list, so the seam is a comment on
    `TaskSubtaskRequest` naming that whitelist, and no fake call. A pull
    now keeps these device-only keys from the device's own row (same
    step by title at the same position), the way it already keeps
    `notifId`, instead of wiping them.
  * **Tour fragment updated** (`templates/tour/productivity.tour.yaml`):
    `productivity_task_compose` reaches the "From template" chooser,
    `productivity_maintenance_readings` opens a softener service at its
    readings step with a value out of spec, and
    `productivity_maintenance_photo` finishes it to the photo step. The
    steps seed one plant and one service run on the device through the
    same repository the page uses; there is no demo repository for
    tasks and none is added.
  * **Tests.** `test/task_step_kinds_test.dart` pins the reading gate
    (empty, out of spec, in spec, the note as the route out), the
    optional Skip against the required step, the overnight clock with
    an injected DateTime, the map shapes and the pull merge.
    `test/maintenance_templates_test.dart` pins both step lists against
    the one duration map, the 47b block on the brine rinse, the 47d gate,
    the plant record read off a finished setup run, and the due dates.
    `test/task_run_kinds_view_test.dart` drives the drawn card: the
    refusal wording, Finish locked then unlocked, Skip finishing the
    run, a picked photo on the map. Nothing existing was skipped or
    changed. The six database-backed suites that need the composed
    `AppDatabase` still do not load on a bare checkout, as before.
  * Not built here, on purpose: the server columns for readings and
    photos (the `Task Subtask` whitelist and the water thread's service
    log), a scheduler for the 180/365-day intervals (`recurrence` has no
    such Select value; those two repeat by the next template pick), and
    any water screen.

## 1.4.0

* Design strip **section 41 — the M2 vision cluster** (frames 41a, 41b,
  41c, 41d; approved 2026-08-30 13:18Z). The legacy JuvoONE Plans /
  Mastery tabs reborn in the settled plane language on the REAL
  productivity backend — new screens for the productivity gate (approved
  7e, coverage group M2); nothing existed in Dart before this.
  * **41a — plan on a page** (`/vision`, `templates/pages/vision/plan_on_a_page.dart`):
    the board DECLARES ALL. Header + count pill ("3 pillars · 6
    objectives", canonical 700), the **785 vision masthead** across the
    claim (the single Plan On A Page doc's linked Vision: eye tile,
    title + "Vision" tag, statement line), then **786 one pillar per
    plane-aligned column** (accent-tinted header: glyph + title +
    objective-count badge + description) with **787 objective cards**
    (title, description, accent "N KPIs" pill, chevron). Accent and
    glyph are PRESENTATION-ONLY and positional — the Pillar doctype has
    no icon / colour / display_order (flag b); the KPI count is DERIVED
    by counting `get_kpis`, and an unreadable count draws no pill.
  * **41b — the drill**: tapping an objective pushes its detail with the
    default one-plane claim; newest wins, the detail takes the LAST
    plane and the board compresses beside it — same columns, tighter
    dress — with the tapped card lit primary + "Selected" (**788**).
    The **789 detail pane** carries the **790 breadcrumb** (Vision ›
    Pillar, the pillar leg in its accent), the title + description and
    the **791 KPI cards** — title + description ONLY, no gauge: the KPI
    doctype has no metric / target / current / unit (flag b). The corner
    pill pops the detail and the board re-spreads.
  * **41c — personal mastery** (`/vision/mastery`,
    `templates/pages/vision/personal_mastery_page.dart`) in the
    sec-33/38 list language: header + "4 goals" pill (700), the **794
    weekly check-in strip** naming the two shipped schedulers as page
    facts (Monday check-in · `send_weekly_goal_reminders`; Friday wins ·
    `send_friday_wins_reminders`), then **792 goal cards** in two
    plane-aligned columns (`ListPlaneColumns`) whose only progress
    metric is the `todos` child table — "N of M" pill, thin bar (green
    at complete) — and the rows as **793 check lines** (Closed check /
    Open circle from `ToDo.status`, closed rows dim, `ToDo.date` faint
    at the end). No status tabs: the goal has no status field.
  * **41d — the phone fold** of 41a: one plane, the pillar columns
    become stacked sections, compact masthead and headers, the count
    pill reads "3 pillars"; the drill takes the whole screen. Nothing
    phone-only is minted.
  * **Canonical 347** on every state: both pages are pushed from the
    productivity gate, so each draws the corner back pill (bottom-END)
    itself and folds the full nav; it pops the newest step — the drill
    while one is open, else the page.
  * **`VisionRepositoryFacade` / `VisionRepositoryImpl`** over the
    productivity module's own read cmds through the platform gateway:
    `tenant.api.get_plan_on_a_page` / `get_visions` /
    `get_personal_mastery_goals` (`VisionCmds`, zero Dart callers before
    this) plus the three `ObjectiveCmds` frame 44c already asks. Pillars
    and objectives are required; the masthead and the KPI count are
    dress on the board and a failure there costs only the dress. The
    plan's vision is the doc's link, falling back to the tenant's one
    vision when the link is unset and exactly one exists. VIEW-FIRST
    (flag a): nothing here writes, and `commit_plan` stays unreachable.
  * **Models** (`vision_data.dart`): `Vision`, `Kpi`, `PlanBoard`,
    `MasteryGoal`, `MasteryTodo`, `planText` (a Text Editor field as one
    line). `Pillar` / `StrategicObjective` are frame 44c's, reused, and
    the pillar accent is `pillarAccent` from the picker, so the two
    screens agree on a pillar's colour.
  * **Honest gap, drawn honestly:** `get_personal_mastery_goals` is a
    `frappe.get_all` and returns title / description only — no `todos`
    rows. `MasteryGoal.todos` is read when the row carries them and is
    NULL otherwise, and a null draws no progress at all rather than
    "0 of 0". Extending the endpoint to send the child table is the
    backend follow-up that lights 792's bar and 793's lines.
  * Routes `/vision` and `/vision/mastery` registered; the launcher glance
    integration gains two `GlanceCardItem`s beside Tasks so the pages are
    reachable in hosts that compose launch_sdk. The hub-side door (rows
    under the manager hub's productivity group) is the commerce side of
    the section and is not in this release, like the tasks-row markers.
  * Tests: `test/vision_cluster_test.dart` (the board at three planes,
    the fold at one, the drill's selected card and detail pane, the
    mastery card's derived progress, the empty states) and
    `test/vision_repository_test.dart` (the gateway names asked, the
    vision resolution, `get_kpis` failing costing the count and not the
    board, `todos` read when sent and null when not).

## 1.3.2

* **The tasks page paints the theme ground again.** Every page-level
  `Scaffold` in `templates/pages/tasks/tasks_page.dart` (the list plane,
  the compose pane, the run pane and the objective picker) was built
  with `backgroundColor: AppStyle.transparent`, and nothing beneath the
  page paints a ground: base_sdk's `PlaneHost` lays its planes side by
  side over a bare seam and leaves an unclaimed plane an empty stage,
  `AdaptiveShell` adds nothing, and the app theme sets no
  `scaffoldBackgroundColor`. The page therefore showed the platform's
  raw surface — opaque black on Android — in BOTH theme modes: in light
  mode the `Tasks` title (`#1B1B20` ink) was invisible and the search
  field and sort segment sat as white boxes on black; in dark mode the
  ground was `#000000` instead of the theme's `#101010`. It showed up as
  the `productivity_tasks` still of the minilauncher guided tour. The
  four Scaffolds now paint `AppStyle.surfaceDark` — the per-mode surface
  token (light `#ECECEF`, dark `#101010`) that `task_run_page.dart` and
  calc's `CalculatorView` already paint — and the page paints the same
  token once behind the `PlaneHost`, so the seam and the empty stage on
  a wide window carry the ground too. No layout, control or handler
  changed.

## 1.3.1

* **A demo build no longer reports a failed sync.** `TaskPullService.pull`
  ran `api.projects.list_personal_tasks` even under
  `--dart-define=IS_DEMO=true`, where there is no backend by design, so
  every demo pull failed, set `lastFailure`, and the tasks page's empty
  state drew "Sync paused. Your tasks will sync when the connection is
  back." — a connection-failure notice on a build that has no connection
  to fail. It showed up as the `productivity_tasks` still of the
  paas_manager guided tour. The pull is now gated on `AppConstants.isDemo`,
  the same gate the other SDKs put in front of their network paths: in a
  demo build it resolves as a successful no-op (0 rows, `lastFailure`
  cleared, no telemetry, nothing on the wire). `TaskSyncNotice`, the
  `syncFailed` status and the telemetry event are unchanged for real
  builds. `TaskPullService.isDemoOverride` (`@visibleForTesting`) lets a
  test stand in a demo build, since the constant is fixed at compile time.

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
