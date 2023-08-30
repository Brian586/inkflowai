// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBtgwwRy7fUVOtdnABXGYARVz-4olh4B_o',
    appId: '1:260846165926:web:b4856208dfac662b4d7967',
    messagingSenderId: '260846165926',
    projectId: 'inkflowai',
    authDomain: 'inkflowai.firebaseapp.com',
    storageBucket: 'inkflowai.appspot.com',
    measurementId: 'G-H608VWC075',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0GdQJOPn3Aq6geSvrtEDC9a3D7HUCDSI',
    appId: '1:260846165926:android:ccdf5f4d5e7433754d7967',
    messagingSenderId: '260846165926',
    projectId: 'inkflowai',
    storageBucket: 'inkflowai.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC37-Q5yOgiC48mlvk5j-t2-oYne2tfJaM',
    appId: '1:260846165926:ios:8ec675860405cacf4d7967',
    messagingSenderId: '260846165926',
    projectId: 'inkflowai',
    storageBucket: 'inkflowai.appspot.com',
    iosClientId: '260846165926-u0o61ukqbld7u434ar3f3thh3o9dgoe2.apps.googleusercontent.com',
    iosBundleId: 'com.inkflowai.inkflowai',
  );
}