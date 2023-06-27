import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../domain.dart';

class UpdatePeriodUseCaseImpl
    implements UseCase<UpdatePeriodParams, PeriodEntity> {
  PeriodRepository repository;

  UpdatePeriodUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, PeriodEntity>> call(UpdatePeriodParams params) {
    return repository.updatePeriod(params);
  }
}
