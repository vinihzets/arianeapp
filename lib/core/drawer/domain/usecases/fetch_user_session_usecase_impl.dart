import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/drawer/domain/repositories/custom_drawer_repository.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

class FetchUserSessionUseCaseImpl
    implements UseCase<FetchUserSessionParams, UserEntity> {
  CustomDrawerRepository repository;

  FetchUserSessionUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(
      FetchUserSessionParams params) async {
    return repository.fetchUserSession(params);
  }
}

class FetchUserSessionParams {}
