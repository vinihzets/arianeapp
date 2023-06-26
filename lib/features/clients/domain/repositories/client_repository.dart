import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ClientRepository {
  Future<Either<Failure, ClientEntity>> createClient(CreateClientParams params);
  Future<Either<Failure, List<ClientEntity>>> readClient();
  Future<Either<Failure, dynamic>> deleteClient(DeleteClientParams entity);
  Future<Either<Failure, ClientEntity>> updateClient(UpdateClientParams params);
}
