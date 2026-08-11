// Copied at compose time from package:subscriptions_sdk/src/common/infrastructure/database/drift_tables.dart by sdk_installer_base.py's update_database_registration() -
// drift only understands table classes inside its own package.
import 'package:drift/drift.dart';

@DataClassName('UserSubscriptionEntity')
class UserSubscriptionsTable extends Table {
  TextColumn get userId => text()();
  TextColumn get status => text()();
  BoolColumn get active => boolean()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  TextColumn get allowedSubjects => text()();

  @override
  Set<Column> get primaryKey => {userId};
}
