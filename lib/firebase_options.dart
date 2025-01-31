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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1K8wkGmumfdTtzrCsEdwhJ2SAcqdbRQ8',
    appId: '1:301610563638:ios:ea7ed362f689800a81c097',
    messagingSenderId: '301610563638',
    projectId: 'ecowize2',
    storageBucket: 'ecowize2.firebasestorage.app',
    iosBundleId: 'com.example.EcoWize',
  );

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyD36RenBxWPdIDapOLlQobNlN5hnoSgeXs",
      authDomain: "ecowize-3a880.firebaseapp.com",
      projectId: "ecowize-3a880",
      storageBucket: "ecowize-3a880.firebasestorage.app",
      messagingSenderId: "6874970823",
      appId: "1:6874970823:web:6d9fde614734c7148fdce2"

  );


  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBVkV1gjl57smLMe6fYYTljtbqbojCHrg',
    appId: '1:6874970823:ios:b070d5e015907f2f8fdce2',
    messagingSenderId: '6874970823',
    projectId: 'ecowize-3a880',
    storageBucket: 'ecowize-3a880.firebasestorage.app',
    iosBundleId: 'com.example.EcoWize',
  );

}
