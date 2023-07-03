import 'package:ariane_app/core/architecture/architecture.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/periods/domain/domain.dart';
import 'package:ariane_app/features/type_perfurations/domain/domain.dart';
import 'package:dartz/dartz.dart';

class ReadPeriodsUseCaseImpl implements UseCase<NoParams, List<PeriodEntity>> {
  TypePerfurationRepository repository;

  ReadPeriodsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<PeriodEntity>>> call(NoParams params) {
    return repository.readPeriods();
  }
}
