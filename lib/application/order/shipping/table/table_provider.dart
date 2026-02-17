import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'table_state.dart';
import 'table_notifier.dart';

final tableProvider = StateNotifierProvider<TableNotifier, TableState>(
  (ref) => TableNotifier(),
);
