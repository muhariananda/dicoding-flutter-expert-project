import 'package:firebase_core/firebase_core.dart';
import 'package:monitoring/src/firebase_options.dart';

export 'src/firebase_options.dart';

Future<void> initializeFirebasePackage() => Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
