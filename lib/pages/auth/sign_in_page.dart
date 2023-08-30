import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'common_widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      // showAuthActionSwitch: false,
      headerBuilder: headerBuilder,
      subtitleBuilder: subtitleBuilder,
      providerConfigs: providerConfigs,
      footerBuilder: footerBuilder,
    );
  }
}
