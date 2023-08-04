import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/client_perfurations/domain/repositories/client_perfurations_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteClientPerfurationUseCaseImpl
    implements UseCase<DeleteClientPerfurationParams, void> {
  ClientPerfurationsRepository repository;

  DeleteClientPerfurationUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteClientPerfurationParams params) {
    return repository.deleteClientPerfuration(params);
  }
}
