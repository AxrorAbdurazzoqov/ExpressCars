// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDjhOyjjhNT5HbUaJIcSrod4NdoUrY2L_0',
    appId: '1:208836538948:web:af4d5c37984cd928d08211',
    messagingSenderId: '208836538948',
    projectId: 'expresscars-ea1d5',
    authDomain: 'expresscars-ea1d5.firebaseapp.com',
    storageBucket: 'expresscars-ea1d5.appspot.com',
    measurementId: 'G-9DDYSRNT4K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-rLwIH69nucjzHEXuQldL6ibhtFH49xI',
    appId: '1:208836538948:android:416eac24216b75c7d08211',
    messagingSenderId: '208836538948',
    projectId: 'expresscars-ea1d5',
    storageBucket: 'expresscars-ea1d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBF3mxTPDuPFGxB4skIAulHNdfvOjl3EAg',
    appId: '1:208836538948:ios:570a30a358454a60d08211',
    messagingSenderId: '208836538948',
    projectId: 'expresscars-ea1d5',
    storageBucket: 'expresscars-ea1d5.appspot.com',
    iosBundleId: 'com.nite.expressCars',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBF3mxTPDuPFGxB4skIAulHNdfvOjl3EAg',
    appId: '1:208836538948:ios:570a30a358454a60d08211',
    messagingSenderId: '208836538948',
    projectId: 'expresscars-ea1d5',
    storageBucket: 'expresscars-ea1d5.appspot.com',
    iosBundleId: 'com.nite.expressCars',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDjhOyjjhNT5HbUaJIcSrod4NdoUrY2L_0',
    appId: '1:208836538948:web:624b90af9ed17eb0d08211',
    messagingSenderId: '208836538948',
    projectId: 'expresscars-ea1d5',
    authDomain: 'expresscars-ea1d5.firebaseapp.com',
    storageBucket: 'expresscars-ea1d5.appspot.com',
    measurementId: 'G-KD70EXDY2C',
  );
}