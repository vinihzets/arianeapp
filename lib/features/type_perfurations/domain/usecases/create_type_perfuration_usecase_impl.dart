import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:ariane_app/features/type_perfurations/domain/repositories/type_perfuration_repository.dart';
import 'package:dartz/dartz.dart';

class CreateTypePerfurationUseCaseImpl
    implements UseCase<CreateTypePerfurationParams, TypePerfurationEntity> {
  TypePerfurationRepository repository;

  CreateTypePerfurationUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, TypePerfurationEntity>> call(CreateTypePerfurationParams params) {
    return repository.createTypePerfuration(params);
  }
}
