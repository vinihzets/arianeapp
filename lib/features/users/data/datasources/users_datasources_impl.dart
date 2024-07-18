import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/users/data/datasources/users_datasources.dart';
import 'package:ariane_app/features/users/data/mappers/user_mapper.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/usecases/change_user_role_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/create_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';

class UsersDataSourcesImpl implements UsersDataSources {
  DatabaseService databaseService;
  UserMapper userMapper;
  AuthService authService;

  UsersDataSourcesImpl({
    required this.databaseService,
    required this.userMapper,
    required this.authService,
  });

  @override
  Future<List<UserEntity>> fetchUsers(FetchUsersParams params) async {
    final users = await databaseService.users.get();

    return users.docs.map((e) => userMapper.fromMap(e.data())).toList();
  }

  @override
  Future<UserEntity> createUser(CreateUserParams params) async {
    final credential = await authService.auth.createUserWithEmailAndPassword(
        email: params.email, password: params.password);

    if (credential.user != null) {
      await databaseService.users
          .doc(credential.user!.uid)
          .set({'email': params.email, 'role': params.role});

      return UserEntity(email: params.email, role: params.role);
    }

    throw RemoteFailure(
        message: 'Ops! Não foi possivel cadastrar um novo Usuário');
  }

  @override
  Future<void> changeUserRole(ChangeUserRoleParams params) async {
    // TODO: implement changeUserRole
    throw UnimplementedError();
  }
}
