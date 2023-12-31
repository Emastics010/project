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
    apiKey: 'AIzaSyDx5dEwJGcWnk-M9671DtgZ6azOowhF1pQ',
    appId: '1:370571522318:web:8e688ad53f0ff289d6275f',
    messagingSenderId: '370571522318',
    projectId: 'new-project-799c1',
    authDomain: 'new-project-799c1.firebaseapp.com',
    storageBucket: 'new-project-799c1.appspot.com',
    measurementId: 'G-187QQW7KT1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVEL94XzNiBKTbO3Vlz6wfal0nNevTxEA',
    appId: '1:370571522318:android:2341aacc716d6fa8d6275f',
    messagingSenderId: '370571522318',
    projectId: 'new-project-799c1',
    storageBucket: 'new-project-799c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARnEINEoeNu23nCojWqxR7FPXkD_U25pg',
    appId: '1:370571522318:ios:6f38371290ce8be4d6275f',
    messagingSenderId: '370571522318',
    projectId: 'new-project-799c1',
    storageBucket: 'new-project-799c1.appspot.com',
    iosClientId: '370571522318-43l9vs9a1i3k9if2cpdjjf2lp8edtkkv.apps.googleusercontent.com',
    iosBundleId: 'com.example.work',
  );
}
