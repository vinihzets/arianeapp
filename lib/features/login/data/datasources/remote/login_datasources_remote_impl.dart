import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/auth_service.dart';
import 'package:ariane_app/core/utils/const_routes.dart';
import 'package:ariane_app/features/login/data/datasources/login_datasources.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDataSourcesRemoteImpl implements LoginDataSources {
  ConstRoutes routes;
  AuthService authService;

  LoginDataSourcesRemoteImpl(this.routes, this.authService);

  @override
  Future<UserCredential> signIn(SignInParams params) async {
    return authService.auth.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}
