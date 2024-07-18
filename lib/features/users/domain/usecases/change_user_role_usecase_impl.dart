import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

class ChangeUserRoleUseCaseImpl implements UseCase<ChangeUserRoleParams, void> {
  UsersRepository repository;

  ChangeUserRoleUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(ChangeUserRoleParams params) {
    return repository.changeUserRole(params);
  }
}

class ChangeUserRoleParams {}
