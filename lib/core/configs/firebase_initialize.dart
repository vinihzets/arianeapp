import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseInitialize {
  static build() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
  }
}
