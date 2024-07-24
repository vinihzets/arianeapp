import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseInitialize {
  static Future<FirebaseApp> build() async {
    WidgetsFlutterBinding.ensureInitialized();

    return await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCo4Ur_cc8_iH1aFTBLaBqffggMCn1_fzw",
      authDomain: "arianeapp-9faa5.firebaseapp.com",
      projectId: "arianeapp-9faa5",
      storageBucket: "arianeapp-9faa5.appspot.com",
      messagingSenderId: "236280198203",
      appId: "1:236280198203:web:95ed0c7e2f2a5b5d23d81e",
      measurementId: "G-0W6S2V7Z4V",
    ));
  }
}
