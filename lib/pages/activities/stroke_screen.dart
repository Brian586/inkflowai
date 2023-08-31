import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class StrokeScreen extends StatelessWidget {
  const StrokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Stroke",
      body: Container(),
      actions: [],
      isScrollable: false,
    );
  }
}
