import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class PaintScreen extends StatelessWidget {
  const PaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Colour Images",
      body: Container(),
      actions: [],
      isScrollable: false,
    );
  }
}
