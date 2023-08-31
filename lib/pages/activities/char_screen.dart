import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Identify Characters",
      body: Container(),
      actions: [],
      isScrollable: false,
    );
  }
}
