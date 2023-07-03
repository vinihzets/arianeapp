import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/perfuration/domain/entities/perfuration_entity.dart';
import 'package:ariane_app/features/perfuration/domain/repositories/perfuration_repository.dart';
import 'package:dartz/dartz.dart';

class ReadPerfurationsUseCaseImpl
    implements UseCase<NoParams, List<PerfurationEntity>> {
  PerfurationRepository repository;

  ReadPerfurationsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<PerfurationEntity>>> call(NoParams params) {
    return repository.readPerfuration();
  }
}
