import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUseCaseImpl implements UseCase<UpdateUserParams, void> {
  UsersRepository repository;

  UpdateUserUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserParams params) {
    return repository.updateUser(params);
  }
}

class UpdateUserParams {
  final String id;
  final int role;
  final DateTime date;

  UpdateUserParams({required this.id, required this.role, required this.date});
}
