import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/auth_service.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/register/data/datasources/register_datasources.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterDataSourcesRemoteImpl implements RegisterDataSources {
  AuthService authService;
  DatabaseService databaseService;
  RegisterDataSourcesRemoteImpl(this.authService, this.databaseService);

  @override
  Future<UserCredential> signUp(SignUpParams params) {
    databaseService.users.add({'email': params.email});

    return authService.auth.createUserWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}
