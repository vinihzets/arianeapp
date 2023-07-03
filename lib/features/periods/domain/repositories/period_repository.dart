import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/global/entities/period_entity.dart';

abstract class PeriodRepository {
  Future<Either<Failure, PeriodEntity>> createPeriod(CreatePeriodParams params);
  Future<Either<Failure, List<PeriodEntity>>> readPeriod();
  Future<Either<Failure, dynamic>> deletePeriod(DeletePeriodParams entity);
  Future<Either<Failure, PeriodEntity>> updatePeriod(UpdatePeriodParams params);
}
