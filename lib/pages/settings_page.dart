import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Settings",
      body: Container(),
      actions: [],
      isScrollable: true,
    );
  }
}
