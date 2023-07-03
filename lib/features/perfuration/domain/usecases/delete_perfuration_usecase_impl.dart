import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../domain.dart';

class DeletePerfurationUseCaseImpl
    implements UseCase<DeletePerfurationParams, dynamic> {
  PerfurationRepository repository;

  DeletePerfurationUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(DeletePerfurationParams params) {
    return repository.deletePerfuration(params);
  }
}
