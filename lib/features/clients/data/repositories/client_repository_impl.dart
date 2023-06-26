import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/data/datasources/client_datasources.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:ariane_app/features/clients/domain/repositories/client_repository.dart';
import 'package:dartz/dartz.dart';

class ClientRepositoryImpl implements ClientRepository {
  ClientDataSources dataSources;

  ClientRepositoryImpl(this.dataSources);
  @override
  Future<Either<Failure, ClientEntity>> createClient(
      CreateClientParams params) async {
    try {
      return Right(await dataSources.createClient(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> readClient() async {
    try {
      return Right(await dataSources.readClient());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteClient(DeleteClientParams params) async {
    try {
      return Right(await dataSources.deleteClient(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientEntity>> updateClient(
      UpdateClientParams params) async {
    try {
      return Right(await dataSources.updateClient(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
