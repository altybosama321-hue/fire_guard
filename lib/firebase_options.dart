import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// [FirebaseOptions] configured with exact project credentials for `fire-guard-ba9b3`.
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
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDQY-LJaHkP9ira-l8FE748ZpFeLBxYkPY',
    appId: '1:291757392615:web:2135129be9089cd5a1d842',
    messagingSenderId: '291757392615',
    projectId: 'fire-guard-ba9b3',
    authDomain: 'fire-guard-ba9b3.firebaseapp.com',
    databaseURL: 'https://fire-guard-ba9b3-default-rtdb.firebaseio.com',
    storageBucket: 'fire-guard-ba9b3.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQY-LJaHkP9ira-l8FE748ZpFeLBxYkPY',
    appId: '1:291757392615:android:2135129be9089cd5a1d842',
    messagingSenderId: '291757392615',
    projectId: 'fire-guard-ba9b3',
    databaseURL: 'https://fire-guard-ba9b3-default-rtdb.firebaseio.com',
    storageBucket: 'fire-guard-ba9b3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQY-LJaHkP9ira-l8FE748ZpFeLBxYkPY',
    appId: '1:291757392615:ios:2135129be9089cd5a1d842',
    messagingSenderId: '291757392615',
    projectId: 'fire-guard-ba9b3',
    databaseURL: 'https://fire-guard-ba9b3-default-rtdb.firebaseio.com',
    storageBucket: 'fire-guard-ba9b3.firebasestorage.app',
    iosBundleId: 'com.fireguard.fire_guard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQY-LJaHkP9ira-l8FE748ZpFeLBxYkPY',
    appId: '1:291757392615:ios:2135129be9089cd5a1d842',
    messagingSenderId: '291757392615',
    projectId: 'fire-guard-ba9b3',
    databaseURL: 'https://fire-guard-ba9b3-default-rtdb.firebaseio.com',
    storageBucket: 'fire-guard-ba9b3.firebasestorage.app',
    iosBundleId: 'com.fireguard.fire_guard',
  );
}
