import 'package:flutter/material.dart';

/// Phoenix widget - allows restarting the entire app
class Phoenix extends StatefulWidget {
  final Widget child;

  const Phoenix({super.key, required this.child});

  @override
  State<Phoenix> createState() => _PhoenixState();

  /// Restart the app by rebuilding from the root
  static void rebirth(BuildContext context) {
    context.findAncestorStateOfType<_PhoenixState>()?.restartApp();
  }
}

class _PhoenixState extends State<Phoenix> {
  Key _key = UniqueKey();

  void restartApp() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
