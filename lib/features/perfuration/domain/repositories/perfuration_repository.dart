import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/perfuration/domain/entities/perfuration_entity.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:dartz/dartz.dart';

abstract class PerfurationRepository {
  Future<Either<Failure, PerfurationEntity>> createPerfuration(
      CreatePerfurationParams params);
  Future<Either<Failure, List<PerfurationEntity>>> readPerfuration();
  Future<Either<Failure, dynamic>> deletePerfuration(
      DeletePerfurationParams entity);

  Future<Either<Failure, List<TypePerfurationEntity>>> readTypePerfurations();
}
