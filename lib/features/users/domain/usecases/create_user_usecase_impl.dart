import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUserUseCaseImpl implements UseCase<CreateUserParams, UserEntity> {
  UsersRepository repository;

  CreateUserUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(CreateUserParams params) {
    return repository.createUser(params);
  }
}

class CreateUserParams {
  final String email;
  final String password;
  final int role;

  CreateUserParams(
      {required this.email, required this.password, required this.role});
}
