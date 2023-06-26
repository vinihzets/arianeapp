import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/client_entity.dart';

class UpdateClientUseCaseImpl
    implements UseCase<UpdateClientParams, ClientEntity> {
  ClientRepository repository;

  UpdateClientUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, ClientEntity>> call(UpdateClientParams params) {
    return repository.updateClient(params);
  }
}
