import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class ReadClientUseCaseImpl
    implements UseCase<GetClientsParams, List<ClientEntity>> {
  ClientRepository repository;

  ReadClientUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<ClientEntity>>> call(GetClientsParams params) {
    return repository.readClient(params);
  }
}
