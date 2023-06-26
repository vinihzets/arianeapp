import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterDataSources {
  Future<UserCredential> signUp(SignUpParams params);
}
