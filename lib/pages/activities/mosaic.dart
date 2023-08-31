import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';

class MosaicScreen extends StatefulWidget {
  const MosaicScreen({super.key});

  @override
  State<MosaicScreen> createState() => _MosaicScreenState();
}

class _MosaicScreenState extends State<MosaicScreen> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveUI(
      appbarTitle: "Mosaic",
      body: Container(),
      actions: [],
      isScrollable: false,
    );
  }
}
