// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import 'package:base_sdk/src/constants/app_constants.dart';
import 'package:base_sdk/src/services/local_storage.dart';

/// The signed-in seller's shop docname: the cached shop JSON first
/// (orders_sdk's `LocalStorage.getShopJson()?['id']` precedent), then the
/// profile's shop. Demo composes answer with the demo shop so the screens
/// render without a session.
String? sellerShopId() {
  final cached = LocalStorage.getShopJson()?['id']?.toString();
  if (cached != null && cached.isNotEmpty) return cached;
  final profile = LocalStorage.getUser()?.shop?.id;
  if (profile != null && profile.isNotEmpty) return profile;
  return AppConstants.isDemo ? 'demo-shop' : null;
}
