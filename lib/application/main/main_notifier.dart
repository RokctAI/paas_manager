import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_state.dart';
import 'package:venderfoodyman/infrastructure/services/services.dart';

class MainNotifier extends StateNotifier<MainState> {
  MainNotifier() : super(const MainState());

  void selectIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void changeScrolling(bool isScrolling) {
    state = state.copyWith(isScrolling: isScrolling);
  }

  bool checkGuest() {
    return LocalStorage.getToken().isEmpty;
  }
}
