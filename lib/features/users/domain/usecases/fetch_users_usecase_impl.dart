import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

class FetchUsersUseCaseImpl implements UseCase<FetchUsersParams, dynamic> {
  UsersRepository repository;

  FetchUsersUseCaseImpl(this.repository);
  @override
  Future<Either<Failure, dynamic>> call(FetchUsersParams params) async {
    return repository.fetchUsers(params);
  }
}

class FetchUsersParams {}
