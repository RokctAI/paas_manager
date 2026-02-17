import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_state.dart';
import 'login_notifier.dart';
import '../../domain/di/dependency_manager.dart';

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(authRepository, usersRepository),
);
