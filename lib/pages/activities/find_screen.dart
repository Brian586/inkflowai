import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class FindScreen extends StatelessWidget {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Find Objects",
      body: Container(),
      actions: [],
      isScrollable: false,
    );
  }
}
