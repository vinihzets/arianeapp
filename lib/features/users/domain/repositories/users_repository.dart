import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/usecases/change_user_role_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/create_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';
import 'package:dartz/dartz.dart';

abstract class UsersRepository {
  Future<Either<Failure, dynamic>> fetchUsers(FetchUsersParams params);
  Future<Either<Failure, UserEntity>> createUser(CreateUserParams params);
  Future<Either<Failure, void>> changeUserRole(ChangeUserRoleParams params);
}
