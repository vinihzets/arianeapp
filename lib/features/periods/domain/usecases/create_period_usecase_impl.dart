import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../../periods.dart';

class CreatePeriodUseCaseImpl
    implements UseCase<CreatePeriodParams, PeriodEntity> {
  PeriodRepository repository;

  CreatePeriodUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, PeriodEntity>> call(CreatePeriodParams params) {
    return repository.createPeriod(params);
  }
}
