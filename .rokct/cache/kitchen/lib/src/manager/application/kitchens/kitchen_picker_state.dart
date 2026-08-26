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

import 'package:flutter/material.dart';
import 'package:kitchen_sdk/src/common/infrastructure/models/data/kitchen_data.dart';

/// Plain immutable state rather than a `freezed` union — keeps `kitchen_sdk`
/// analyzable without a `build_runner` pass. (Sibling SDKs are split on this:
/// `orders_sdk`/`auth_sdk` commit their generated files, `products_sdk` does
/// not.)
class KitchenPickerState {
  const KitchenPickerState({
    this.isLoading = false,
    this.kitchens = const [],
    this.activeIndex = 0,
    this.selected,
    this.error,
    this.kitchenController,
  });

  final bool isLoading;
  final List<KitchenModel> kitchens;
  final int activeIndex;
  final KitchenModel? selected;

  /// Set on a failed fetch. The app's two variants disagreed here — the create
  /// notifier took a `BuildContext` and raised a snackbar itself, the edit one
  /// swallowed the failure. Neither belongs in the application layer, so the
  /// failure is surfaced as state and the presentation layer decides.
  final String? error;

  final TextEditingController? kitchenController;

  KitchenPickerState copyWith({
    bool? isLoading,
    List<KitchenModel>? kitchens,
    int? activeIndex,
    KitchenModel? selected,
    String? error,
    TextEditingController? kitchenController,
  }) =>
      KitchenPickerState(
        isLoading: isLoading ?? this.isLoading,
        kitchens: kitchens ?? this.kitchens,
        activeIndex: activeIndex ?? this.activeIndex,
        selected: selected ?? this.selected,
        error: error,
        kitchenController: kitchenController ?? this.kitchenController,
      );
}
