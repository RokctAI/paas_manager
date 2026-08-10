// This file is part of paas_manager.
// Copyright (C) 2024 RokctAI
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_initializer.dart';

class AppInitializerWidget extends StatefulWidget {
  final Widget child;

  const AppInitializerWidget({super.key, required this.child});

  @override
  _AppInitializerWidgetState createState() => _AppInitializerWidgetState();
}

class _AppInitializerWidgetState extends State<AppInitializerWidget> {
  bool _isInitialized = false;
  late ProviderContainer _providerContainer;

  @override
  void initState() {
    super.initState();
    _providerContainer = ProviderContainer();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final appInitializer = AppInitializer(providerContainer: _providerContainer);
    await appInitializer.initializeRemoteConfigWithoutAPICall();
    await appInitializer.checkAppStatusFromAPI();

    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _providerContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? UncontrolledProviderScope(
      container: _providerContainer,
      child: widget.child,
    )
        : Scaffold(
      body: Center(
        child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
      ),
    );
  }
}
