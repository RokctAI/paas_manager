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
