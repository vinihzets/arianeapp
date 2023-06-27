import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';

import 'package:dartz/dartz.dart';

import '../repositories/period_repository.dart';

class DeletePeriodUseCaseImpl implements UseCase<DeletePeriodParams, dynamic> {
  PeriodRepository repository;

  DeletePeriodUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(DeletePeriodParams entity) {
    return repository.deletePeriod(entity);
  }
}
