import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:revenue_sdk/src/manager/application/statistics/statistics_notifier.dart';
import 'package:revenue_sdk/src/manager/application/statistics/statistics_state.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';

final statisticsProvider =
    StateNotifierProvider<StatisticsNotifier, StatisticsState>(
  (ref) => StatisticsNotifier(
    GetIt.instance<SellerStatisticsRepositoryFacade>(),
  ),
);
