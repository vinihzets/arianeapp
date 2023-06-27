import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../../periods.dart';

class PeriodRepositoryImpl implements PeriodRepository {
  PeriodDataSources dataSources;

  PeriodRepositoryImpl(this.dataSources);
  @override
  Future<Either<Failure, PeriodEntity>> createPeriod(
      CreatePeriodParams params) async {
    try {
      return Right(await dataSources.createPeriod(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeriodEntity>>> readPeriod() async {
    try {
      return Right(await dataSources.readPeriod());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePeriod(DeletePeriodParams params) async {
    try {
      return Right(await dataSources.deletePeriod(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PeriodEntity>> updatePeriod(
      UpdatePeriodParams params) async {
    try {
      return Right(await dataSources.updatePeriod(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
