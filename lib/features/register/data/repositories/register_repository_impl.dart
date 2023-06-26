import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/register/data/datasources/register_datasources.dart';
import 'package:ariane_app/features/register/domain/repositories/register_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  RegisterDataSources dataSources;

  RegisterRepositoryImpl(this.dataSources);

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUpParams params) async {
    try {
      return Right(await dataSources.signUp(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
