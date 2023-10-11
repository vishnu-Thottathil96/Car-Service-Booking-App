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
        return macos;
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
    apiKey: 'AIzaSyCeco_flSXbG05G-4Z67VHCDE0TG8l8B_o',
    appId: '1:464770096219:web:4c2e6d90edee845369f37e',
    messagingSenderId: '464770096219',
    projectId: 'motox-15f98',
    authDomain: 'motox-15f98.firebaseapp.com',
    storageBucket: 'motox-15f98.appspot.com',
    measurementId: 'G-FP8BRXDLMH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBo6xucfLAGDFyWSGpc_ppUdqkv4jT-fMk',
    appId: '1:464770096219:android:0bce6e72694b848569f37e',
    messagingSenderId: '464770096219',
    projectId: 'motox-15f98',
    storageBucket: 'motox-15f98.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqpHdxVT2fnEOZYJUV-OZAwdxG6oVfYN8',
    appId: '1:464770096219:ios:37d7ef9fb0aaec4e69f37e',
    messagingSenderId: '464770096219',
    projectId: 'motox-15f98',
    storageBucket: 'motox-15f98.appspot.com',
    iosBundleId: 'com.example.motox',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqpHdxVT2fnEOZYJUV-OZAwdxG6oVfYN8',
    appId: '1:464770096219:ios:2a0f0ca4134afda469f37e',
    messagingSenderId: '464770096219',
    projectId: 'motox-15f98',
    storageBucket: 'motox-15f98.appspot.com',
    iosBundleId: 'com.example.motox.RunnerTests',
  );
}
