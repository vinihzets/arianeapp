import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class CreateClientUseCaseImpl
    implements UseCase<CreateClientParams, ClientEntity> {
  ClientRepository repository;

  CreateClientUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, ClientEntity>> call(CreateClientParams entity) {
    return repository.createClient(entity);
  }
}
