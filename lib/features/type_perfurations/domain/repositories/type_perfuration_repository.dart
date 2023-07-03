import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/periods/domain/domain.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:dartz/dartz.dart';

abstract class TypePerfurationRepository {
  Future<Either<Failure, TypePerfurationEntity>> createTypePerfuration(
      CreateTypePerfurationParams params);
  Future<Either<Failure, List<TypePerfurationEntity>>> readTypePerfuration();
  Future<Either<Failure, dynamic>> deleteTypePerfuration(
      DeleteTypePerfurationParams entity);
  Future<Either<Failure, TypePerfurationEntity>> updateTypePerfuration(
      UpdateTypePerfurationParams params);
  Future<Either<Failure, List<PeriodEntity>>> readPeriods();
}
