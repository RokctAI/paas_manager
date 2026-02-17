import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:venderfoodyman/infrastructure/services/services.dart';

part 'delivery_type_state.freezed.dart';

@freezed
abstract class DeliveryTypeState with _$DeliveryTypeState {
  const factory DeliveryTypeState({@Default(TrKeys.delivery) String type}) =
      _DeliveryTypeState;

  const DeliveryTypeState._();
}
