import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/core/global/entities/period_entity.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:dartz/dartz.dart';

class TypePerfurationRepositoryImpl implements TypePerfurationRepository {
  TypePerfurationDataSources dataSources;

  TypePerfurationRepositoryImpl(this.dataSources);
  @override
  Future<Either<Failure, TypePerfurationEntity>> createTypePerfuration(
      CreateTypePerfurationParams params) async {
    try {
      return Right(await dataSources.createTypePerfuration(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TypePerfurationEntity>>>
      readTypePerfuration() async {
    try {
      return Right(await dataSources.readTypesPerfuration());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTypePerfuration(
      DeleteTypePerfurationParams params) async {
    try {
      final request = dataSources.deleteTypePerfuration(params);
      return Right(request);
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TypePerfurationEntity>> updateTypePerfuration(
      UpdateTypePerfurationParams params) async {
    try {
      return Right(await dataSources.updateTypePerfuration(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeriodEntity>>> readPeriods() async {
    try {
      return Right(await dataSources.readPeriods());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
