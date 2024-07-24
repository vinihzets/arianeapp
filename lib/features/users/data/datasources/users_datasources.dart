import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/usecases/update_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/create_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';

abstract class UsersDataSources {
  Future<dynamic> fetchUsers(FetchUsersParams params);
  Future<UserEntity> createUser(CreateUserParams params);
  Future<void> updateUser(UpdateUserParams params);
}
