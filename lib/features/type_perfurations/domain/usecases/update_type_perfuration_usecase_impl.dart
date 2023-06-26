import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:ariane_app/features/type_perfurations/domain/repositories/type_perfuration_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/type_entity.dart';

class UpdateTypePerfurationsUseCaseImpl
    implements UseCase<UpdateTypePerfurationParams, TypePerfurationEntity> {
  TypePerfurationRepository repository;

  UpdateTypePerfurationsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, TypePerfurationEntity>> call(UpdateTypePerfurationParams params) {
    return repository.updateTypePerfuration(params);
  }
}
