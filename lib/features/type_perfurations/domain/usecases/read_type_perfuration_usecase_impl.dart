import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:dartz/dartz.dart';

class ReadTypePerfurationsUseCaseImpl implements UseCase<NoParams, List<TypePerfurationEntity>> {
  TypePerfurationRepository repository;

  ReadTypePerfurationsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<TypePerfurationEntity>>> call(NoParams params) {
    return repository.readTypePerfuration();
  }
}
