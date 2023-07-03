import 'package:ariane_app/core/architecture/architecture.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/perfuration/perfurations.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:dartz/dartz.dart';


class ReadTypesPerfurationUseCaseImpl
    implements UseCase<NoParams, List<TypePerfurationEntity>> {
  PerfurationRepository repository;

  ReadTypesPerfurationUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<TypePerfurationEntity>>> call(NoParams params) {
    return repository.readTypePerfurations();
  }
}
