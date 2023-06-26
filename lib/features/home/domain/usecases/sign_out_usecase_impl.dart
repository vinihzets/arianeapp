import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ariane_app/core/failure/failure.dart';

class SignOutUseCaseImpl implements UseCase<NoParams, void> {
  HomeRepository repository;

  SignOutUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}
