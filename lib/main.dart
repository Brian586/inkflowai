import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkflowai/config.dart';
import 'package:inkflowai/firebase_options.dart';
import 'package:inkflowai/pages/auth/auth_gate.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.storage.request();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  cameras = await availableCameras();

  runApp(MyApp(
    savedThemeMode: savedThemeMode,
  ));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme:
              GoogleFonts.comfortaaTextTheme().apply(bodyColor: Colors.black),
          useMaterial3: true,
        ),
        dark: ThemeData(
          brightness: Brightness.dark,
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme:
              GoogleFonts.comfortaaTextTheme().apply(bodyColor: Colors.white),
          useMaterial3: true,
        ),
        initial: savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
              title: Config.appName,
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,
              home: const SplashScreen(),
            ));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    displaySplash();
  }

  void displaySplash() async {
    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthGate()));
    });
  }

  Widget splashUI() {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: SizedBox(
          width: 250.0,
          child: Hero(
            tag: Config.appName,
            child: TextLiquidFill(
              text: Config.appName,
              waveColor: Colors.purple,
              boxBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              textStyle: Config.appNameTextStyle.copyWith(fontSize: 50.0),
              boxHeight: 200.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return splashUI();
  }
}
