import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import '../../config.dart';

Widget headerBuilder(context, constraints, shrinkOffset) {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0),
    child: Hero(
      tag: Config.appName,
      child: Text(
        Config.appName,
        textAlign: TextAlign.center,
        style: Config.appNameTextStyle.copyWith(fontSize: 40.0),
      ),
    ),
  );
}

Widget subtitleBuilder(context, action) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      action == AuthAction.signIn
          ? 'Welcome to ${Config.appName}! Please sign in to continue.'
          : 'Welcome to ${Config.appName}! Please create an account to continue',
    ),
  );
}

List<ProviderConfiguration>? providerConfigs = const [
  EmailProviderConfiguration(),
  GoogleProviderConfiguration(clientId: Config.googleWebClientID)
];

Widget footerBuilder(context, _) {
  return const Padding(
    padding: EdgeInsets.only(top: 16),
    child: Text(
      'By signing in, you agree to our terms and conditions.',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey),
    ),
  );
}
