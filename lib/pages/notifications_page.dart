import 'package:flutter/material.dart';
import 'package:inkflowai/widgets/adaptive_ui.dart';
import 'package:inkflowai/widgets/no_data.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveUI(
      appbarTitle: "Notifications",
      body: NoData(
        title: "No Notifications Yet",
      ),
      actions: [],
      isScrollable: true,
    );
  }
}
