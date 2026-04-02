import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'extras_group_details_state.dart';
import 'extras_group_details_notifier.dart';
import 'package:venderfoodyman/domain/di/dependency_manager.dart';

final extrasGroupDetailsProvider =
    StateNotifierProvider<ExtrasGroupDetailsNotifier, ExtrasGroupDetailsState>(
      (ref) => ExtrasGroupDetailsNotifier(productRepository),
    );
