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

import 'package:base_sdk/src/models/data/currency_data.dart';

/// The currency every IS_DEMO seller fixture trades in — South African
/// rand, symbol before the amount ("R150.00") — as one `CurrencyData` the
/// manager DI seeds into `LocalStorage` (see `ManagerMerchantsDependencies`).
///
/// Mirrors orders_sdk's `DemoSellerOrdersRepository._rand` field for field
/// (id `ZAR`, symbol `R`, rate 1, position `before`), the currency its
/// seeded orders and `MockOrdersRepository`'s customer order already carry,
/// so the till, the order board and the history list print the same money.
/// Not a const: `CurrencyData` has no const constructor.
final CurrencyData demoCurrency = CurrencyData(
  id: 'ZAR',
  symbol: 'R',
  title: 'South African Rand',
  rate: 1,
  isDefault: true,
  active: true,
  position: 'before',
);
