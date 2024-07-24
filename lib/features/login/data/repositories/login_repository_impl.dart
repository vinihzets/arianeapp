import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/login/data/datasources/login_datasources.dart';
import 'package:ariane_app/features/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginDataSources dataSources;

  LoginRepositoryImpl(this.dataSources);

  @override
  Future<Either<Failure, UserCredential>> signIn(SignInParams params) async {
    try {
      return Right(await dataSources.signIn(params));
    } on RemoteFailure catch (e) {
      return Left(RemoteFailure(message: e.message));
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
