import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/features/register/domain/repositories/register_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCaseImpl implements UseCase<SignUpParams, UserCredential> {
  RegisterRepository repository;

  SignUpUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) {
    return repository.signUp(params);
  }
}
