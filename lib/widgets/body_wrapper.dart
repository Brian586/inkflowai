import 'package:flutter/material.dart';

class BodyWrapper extends StatelessWidget {
  final Widget? child;
  const BodyWrapper({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600.0, minWidth: 300.0),
      child: child,
    );
  }
}
