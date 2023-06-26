import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/home/data/datasources/home_datasources.dart';
import 'package:ariane_app/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeDataSources dataSources;

  HomeRepositoryImpl(this.dataSources);

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return Right(await dataSources.signOut());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
