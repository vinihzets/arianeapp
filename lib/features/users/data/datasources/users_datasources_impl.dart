import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/users/data/datasources/users_datasources.dart';
import 'package:ariane_app/features/users/data/mappers/user_mapper.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';

class UsersDataSourcesImpl implements UsersDataSources {
  DatabaseService databaseService;
  UserMapper userMapper;

  UsersDataSourcesImpl(
      {required this.databaseService, required this.userMapper});

  @override
  Future<List<UserEntity>> fetchUsers(FetchUsersParams params) async {
    final users = await databaseService.users.get();

    return users.docs.map((e) => userMapper.fromMap(e.data())).toList();
  }
}
