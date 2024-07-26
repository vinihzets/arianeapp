import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/users/data/datasources/users_datasources.dart';
import 'package:ariane_app/features/users/data/mappers/user_mapper.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/usecases/update_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/create_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';

class UsersDataSourcesImpl implements UsersDataSources {
  DatabaseService databaseService;
  UserMapper userMapper;
  AuthService authService;
  SessionStorage storage;

  UsersDataSourcesImpl({
    required this.databaseService,
    required this.userMapper,
    required this.authService,
    required this.storage,
  });

  @override
  Future<List<UserEntity>> fetchUsers(FetchUsersParams params) async {
    final users = await databaseService.users.get();

    return users.docs.map((e) => userMapper.fromMap(e.data())).toList();
  }

  @override
  Future<UserEntity> createUser(CreateUserParams params) async {
    final UserEntity? user = await storage.fetchSession();

    if (user == null) {
      throw RemoteFailure(message: 'Nenhum Usuário em sessão');
    }

    final credential = await authService.auth.createUserWithEmailAndPassword(
        email: params.email, password: params.password);

    if (credential.user != null) {
      await databaseService.users.doc(credential.user!.uid).set({
        'email': params.email,
        'role': params.role,
        'date': params.date.millisecondsSinceEpoch,
        'id': credential.user?.uid ?? '',
      });

      return UserEntity(
          email: params.email,
          role: UserRole.values[params.role],
          date: params.date,
          id: credential.user?.uid ?? '');
    }

    throw RemoteFailure(
        message: 'Ops! Não foi possivel cadastrar um novo Usuário');
  }

  @override
  Future<void> updateUser(UpdateUserParams params) async {
    final UserEntity? user = await storage.fetchSession();

    if (user == null) {
      throw RemoteFailure(message: 'Nenhum Usuário em sessão');
    }

    if (user.role != UserRole.admin) {
      throw RemoteFailure(message: 'Permissões insuficientes!');
    }
    return await databaseService.users.doc(params.id).update(
        {'role': params.role, 'date': params.date.millisecondsSinceEpoch});
  }
}
