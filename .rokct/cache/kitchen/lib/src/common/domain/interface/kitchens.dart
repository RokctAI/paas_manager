/// Contract for the shop's kitchen (prep station) list.
///
/// Declared in this SDK's own `domain/interface/` rather than in `base_sdk`:
/// ADR-005 lets a consumer own the interface it needs, and nothing outside
/// `kitchen_sdk` consumes kitchens directly today. See
/// `docs/frappe-endpoint-contract.md` for endpoint coverage.
library;

import 'package:base_sdk/src/handlers/handlers.dart';
import 'package:kitchen_sdk/src/common/infrastructure/models/response/kitchens_paginate_response.dart';

abstract class KitchensRepositoryFacade {
  Future<ApiResult<KitchensPaginateResponse>> getKitchens({int? perPage});
}
