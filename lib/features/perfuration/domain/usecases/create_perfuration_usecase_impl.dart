import 'package:ariane_app/core/global/entities/perfuration_entity.dart';
import 'package:ariane_app/features/perfuration/domain/repositories/perfuration_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/architecture/usecase.dart';
import '../../../../core/failure/failure.dart';

class CreatePerfurationUseCaseImpl
    implements UseCase<CreatePerfurationParams, PerfurationEntity> {
  PerfurationRepository repository;

  CreatePerfurationUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, PerfurationEntity>> call(
      CreatePerfurationParams params) {
    return repository.createPerfuration(params);
  }
}
