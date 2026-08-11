// Copied at compose time from package:productivity_sdk/src/common/infrastructure/database/tasks_table.dart by sdk_installer_base.py's update_database_registration() -
// drift only understands table classes inside its own package.
import 'package:drift/drift.dart';

@DataClassName('TaskEntity')
class TasksTable extends Table {
  TextColumn get id => text().clientDefault(() => '')(); // UUID
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  // currentDateAndTime is evaluated by SQLite at INSERT time; a
  // Constant(DateTime.now()) default freezes whatever timestamp the build
  // captured, stamping every later row with stale build-time data.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get createdBy => text().nullable()();
  TextColumn get data => text().nullable()(); // JSON blob fallback

  @override
  Set<Column> get primaryKey => {id};
}
