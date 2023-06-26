import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCaseImpl implements UseCase<SignInParams, UserCredential> {
  LoginRepository repository;

  SignInUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignInParams params) {
    return repository.signIn(params);
  }
}
