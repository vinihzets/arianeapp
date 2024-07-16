import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';
import 'package:dartz/dartz.dart';

abstract class UsersRepository {
  Future<Either<Failure, dynamic>> fetchUsers(FetchUsersParams params);
}
