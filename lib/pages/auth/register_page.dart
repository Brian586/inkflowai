import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'common_widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterScreen(
      // showAuthActionSwitch: false,
      headerBuilder: headerBuilder,
      subtitleBuilder: subtitleBuilder,
      providerConfigs: providerConfigs,
      footerBuilder: footerBuilder,
    );
  }
}
