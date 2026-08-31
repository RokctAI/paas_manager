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

import 'package:flutter/material.dart';

import 'package:base_sdk/src/presentation/theme/app_style.dart';
import 'package:base_sdk/src/services/local_storage.dart';
import 'package:kitchen_sdk/src/manager/presentation/kitchen/kitchen_workspace.dart';

/// The manager KITCHEN tab (approved design, Ray 2026-08-29: 13:06Z
/// "approved: … 34b,34c,34d", 13:53Z "approved: 34a …"). Installed to
/// lib/presentation/pages/kitchen/kitchen_page.dart — the exact path
/// merchants_sdk's main_page.dart shell imports; tab-hosted, so it
/// declares no route (orders_sdk's OrdersHomePage contract).
///
/// All machinery lives in the analyzable, tested package code
/// (kitchen_sdk src/manager): [KitchenWorkspace] hosts the queue + detail
/// in base_sdk's plane model — the kitchen declares ALL planes, the
/// selected order's detail takes the LAST plane, phones collapse to
/// queue → pushed detail with the corner back pill by construction.
class KitchenHomePage extends StatelessWidget {
  const KitchenHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLtr = LocalStorage.getLangLtr();
    return Directionality(
      textDirection: isLtr ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppStyle.surfaceDark,
        body: const SafeArea(child: KitchenWorkspace()),
      ),
    );
  }
}
