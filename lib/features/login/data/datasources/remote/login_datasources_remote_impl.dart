import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/login/data/datasources/login_datasources.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDataSourcesRemoteImpl implements LoginDataSources {
  ConstRoutes routes;
  AuthService authService;
  SessionStorage sessionStorage;
  DatabaseService databaseService;
  LoginDataSourcesRemoteImpl(
    this.routes,
    this.authService,
    this.sessionStorage,
    this.databaseService,
  );

  @override
  Future<UserCredential> signIn(SignInParams params) async {
    final credential = await authService.auth.signInWithEmailAndPassword(
        email: params.email, password: params.password);

    final userDoc = await databaseService.users.doc(credential.user?.uid).get();
    if (!userDoc.exists) {
      throw RemoteFailure(
          message: 'Esse Usuário não está registrado no nosso Banco de Dados');
    }
    // role é um inteiro, pode ser 0 -> inativo, 1 -> usuario->Ativo, 2 -> administrador->Ativo, dou o .toString pra converter em uma String e salvar na sessão do localStorage.

    sessionStorage.setSession(
        'session', [params.email, userDoc.data()?['role'].toString() ?? '']);

    return credential;
  }
}
