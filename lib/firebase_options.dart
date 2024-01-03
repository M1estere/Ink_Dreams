import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgMLU7XF3cAxxkEsxRJL7MTgv-YS4sGGg',
    appId: '1:250589267871:android:b0cf69b1a4fb4f2fad1faa',
    messagingSenderId: '250589267871',
    projectId: 'manga-reader-app-d1902',
    databaseURL: 'https://manga-reader-app-d1902-default-rtdb.firebaseio.com',
    storageBucket: 'manga-reader-app-d1902.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAl6mi1NIYDSPXJyGBWwrxagdHBGh7oChk',
    appId: '1:250589267871:ios:1e8745b4307c3d79ad1faa',
    messagingSenderId: '250589267871',
    projectId: 'manga-reader-app-d1902',
    databaseURL: 'https://manga-reader-app-d1902-default-rtdb.firebaseio.com',
    storageBucket: 'manga-reader-app-d1902.appspot.com',
    iosBundleId: 'com.example.mangaReading',
  );
}
