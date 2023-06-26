import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginDataSources {
  Future<UserCredential> signIn(SignInParams params);
}
