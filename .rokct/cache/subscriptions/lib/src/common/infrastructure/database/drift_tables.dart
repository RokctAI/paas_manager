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
