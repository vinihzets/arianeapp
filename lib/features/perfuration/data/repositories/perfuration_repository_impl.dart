import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/perfuration/data/datasources/perfuration_datasources.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/perfuration_entity.dart';
import '../../domain/repositories/perfuration_repository.dart';

class PerfurationRepositoryImpl implements PerfurationRepository {
  PerfurationDataSources dataSources;

  PerfurationRepositoryImpl(this.dataSources);
  @override
  Future<Either<Failure, PerfurationEntity>> createPerfuration(
      CreatePerfurationParams params) async {
    try {
      return Right(await dataSources.createPerfuration(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PerfurationEntity>>> readPerfuration() async {
    try {
      return Right(await dataSources.readPerfuration());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePerfuration(
      DeletePerfurationParams params) async {
    try {
      final request = dataSources.deletePerfuration(params);
      return Right(request);
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TypePerfurationEntity>>>
      readTypePerfurations() async {
    try {
      return Right(await dataSources.readTypePerfurations());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
