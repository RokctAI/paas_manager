// Copyright (c) 2026 RokctAI
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:get_it/get_it.dart';
import 'package:revenue_sdk/src/common/domain/interface/seller_statistics.dart';
import 'package:revenue_sdk/src/manager/infrastructure/repositories/seller_statistics_repository.dart';

/// Manager-role DI hook. Not exported by the barrel and not called by the
/// generated `main.dart` — the common `RevenueSdkDependencies.register` cannot
/// import this file because a driver app's cache has `lib/src/manager/`
/// stripped. A manager host calls this from its own DI setup, importing it via
/// this direct `src/` path, before the installed income page first builds
/// `statisticsProvider` (which resolves the facade from GetIt). Registers
/// idempotently so hand-wired hosts can call it too.
class ManagerRevenueDependencies {
  static void register(GetIt getIt) {
    if (!getIt.isRegistered<SellerStatisticsRepositoryFacade>()) {
      getIt.registerSingleton<SellerStatisticsRepositoryFacade>(
        SellerStatisticsRepository(),
      );
    }
  }
}
