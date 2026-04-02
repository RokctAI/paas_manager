import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:venderfoodyman/domain/di/dependency_manager.dart';
import 'create_user_notifier.dart';
import 'create_user_state.dart';

final createUserProvider =
    StateNotifierProvider.autoDispose<CreateUserNotifier, CreateUserState>(
      (ref) => CreateUserNotifier(usersRepository),
    );
