import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class PickScreen extends StatelessWidget {
  const PickScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Pick Objects",
      body: Container(),
      actions: [],
      isScrollable: false,
    );
  }
}
