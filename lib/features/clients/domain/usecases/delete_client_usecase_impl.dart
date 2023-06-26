import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';

import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteClientUseCaseImpl implements UseCase<DeleteClientParams, dynamic> {
  ClientRepository repository;

  DeleteClientUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(DeleteClientParams entity) {
    return repository.deleteClient(entity);
  }
}
