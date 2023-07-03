import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/perfuration_entity.dart';
import '../repositories/perfuration_repository.dart';

class UpdatePerfurationsUseCaseImpl
    implements UseCase<UpdatePerfurationParams, PerfurationEntity> {
  PerfurationRepository repository;

  UpdatePerfurationsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, PerfurationEntity>> call(
      UpdatePerfurationParams params) {
    return repository.updatePerfuration(params);
  }
}
