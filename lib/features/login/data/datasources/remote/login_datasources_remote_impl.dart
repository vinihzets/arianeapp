import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/login/data/datasources/login_datasources.dart';
import 'package:ariane_app/features/users/data/mappers/user_mapper.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginDataSourcesRemoteImpl implements LoginDataSources {
  ConstRoutes routes;
  AuthService authService;
  SessionStorage sessionStorage;
  DatabaseService databaseService;
  UserMapper userMapper;
  LoginDataSourcesRemoteImpl(
    this.routes,
    this.authService,
    this.sessionStorage,
    this.databaseService,
    this.userMapper,
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

    final user = userMapper.fromMap(userDoc.data()!);

    if (user.date.isBefore(DateTime.now()) && user.role == UserRole.normal) {
      throw RemoteFailure(
        message:
            'Usuário inadimplente, entre em contato com a administradora do sistema!',
      );
    }

    sessionStorage.setSession('session', userMapper.toMap(user));

    return credential;
  }
}
