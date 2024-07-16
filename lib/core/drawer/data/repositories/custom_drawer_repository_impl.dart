import 'package:ariane_app/core/drawer/data/datasources/custom_drawer_datasources.dart';
import 'package:ariane_app/core/drawer/domain/repositories/custom_drawer_repository.dart';
import 'package:ariane_app/core/drawer/domain/usecases/fetch_user_session_usecase_impl.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

class CustomDrawerRepositoryImpl implements CustomDrawerRepository {
  CustomDrawerDataSources dataSources;

  CustomDrawerRepositoryImpl(this.dataSources);

  @override
  Future<Either<Failure, UserEntity>> fetchUserSession(
      FetchUserSessionParams params) async {
    try {
      return Right(await dataSources.fetchUserSession(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
