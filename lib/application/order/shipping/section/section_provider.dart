import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'section_state.dart';
import 'section_notifier.dart';

final sectionProvider = StateNotifierProvider<SectionNotifier, SectionState>(
  (ref) => SectionNotifier(),
);
