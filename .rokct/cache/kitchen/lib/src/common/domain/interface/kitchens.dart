// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
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
