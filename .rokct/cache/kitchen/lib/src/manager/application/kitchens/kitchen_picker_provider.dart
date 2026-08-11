import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:kitchen_sdk/src/manager/application/kitchens/kitchen_picker_notifier.dart';
import 'package:kitchen_sdk/src/manager/application/kitchens/kitchen_picker_state.dart';
import 'package:kitchen_sdk/src/common/domain/interface/kitchens.dart';

/// autoDispose so a create flow and an edit flow never share seeded state.
final kitchenPickerProvider = StateNotifierProvider.autoDispose<
    KitchenPickerNotifier, KitchenPickerState>(
  (ref) => KitchenPickerNotifier(GetIt.instance<KitchensRepositoryFacade>()),
);
