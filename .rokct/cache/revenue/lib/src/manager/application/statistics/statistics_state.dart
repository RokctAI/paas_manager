import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_order_response.dart';
import 'package:revenue_sdk/src/common/infrastructure/models/response/statistics_response.dart';

/// Plain immutable state rather than a `freezed` union.
///
/// Sibling SDKs are split on this — `orders_sdk`/`auth_sdk` commit their
/// generated `*.freezed.dart`, `products_sdk` does not — so a hand-written
/// `copyWith` keeps `revenue_sdk` analyzable without a `build_runner` pass.
///
/// The legacy state also carried a `List<Series<OrdinalSales, String>> list`
/// for `charts_flutter_new`. That dependency was already commented out in
/// `paas_manager` and its producer (`addListInfo`) was a no-op, so it is not
/// carried over.
class StatisticsState {
  const StatisticsState({
    this.isLoading = false,
    this.isRefresh = true,
    this.listOfOrder = const [],
    this.prices = const [],
    this.time = const [],
    this.countData,
  });

  final bool isLoading;
  final bool isRefresh;
  final List<StatisticsOrder> listOfOrder;
  final List<num> prices;
  final List<DateTime> time;
  final StatisticsModel? countData;

  StatisticsState copyWith({
    bool? isLoading,
    bool? isRefresh,
    List<StatisticsOrder>? listOfOrder,
    List<num>? prices,
    List<DateTime>? time,
    StatisticsModel? countData,
  }) =>
      StatisticsState(
        isLoading: isLoading ?? this.isLoading,
        isRefresh: isRefresh ?? this.isRefresh,
        listOfOrder: listOfOrder ?? this.listOfOrder,
        prices: prices ?? this.prices,
        time: time ?? this.time,
        countData: countData ?? this.countData,
      );
}
