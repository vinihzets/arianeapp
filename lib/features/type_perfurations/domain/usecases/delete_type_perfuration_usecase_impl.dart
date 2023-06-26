import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';

import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:ariane_app/features/type_perfurations/domain/repositories/type_perfuration_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteTypePerfurationUseCaseImpl implements UseCase<DeleteTypePerfurationParams, dynamic> {
  TypePerfurationRepository repository;

  DeleteTypePerfurationUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(DeleteTypePerfurationParams params) {
    return repository.deleteTypePerfuration(params);
  }
}
