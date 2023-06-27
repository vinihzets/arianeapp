import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import '../../periods.dart';

class ReadPeriodUseCaseImpl implements UseCase<NoParams, List<PeriodEntity>> {
  PeriodRepository repository;

  ReadPeriodUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<PeriodEntity>>> call(NoParams params) {
    return repository.readPeriod();
  }
}
