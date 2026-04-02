// import 'package:charts_flutter_new/flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:venderfoodyman/infrastructure/models/models.dart';
part 'statistics_state.freezed.dart';

@freezed
abstract class StatisticsState with _$StatisticsState {
  const factory StatisticsState({
    @Default(false) bool isLoading,
    @Default(true) bool isRefresh,
    // @Default([]) List<Series<OrdinalSales, String>> list,
    @Default([]) List<StatisticsOrder> listOfOrder,
    @Default([]) List<num> prices,
    @Default([]) List<DateTime> time,
    StatisticsModel? countData,
  }) = _StatisticsState;

  const StatisticsState._();
}
