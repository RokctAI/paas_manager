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
