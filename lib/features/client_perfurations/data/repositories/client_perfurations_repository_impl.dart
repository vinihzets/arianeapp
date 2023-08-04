import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/core/global/entities/perfuration_entity.dart';
import 'package:ariane_app/features/client_perfurations/data/datasources/client_perfurations_datasources.dart';
import 'package:ariane_app/features/client_perfurations/domain/repositories/client_perfurations_repository.dart';
import 'package:dartz/dartz.dart';

class ClientPerfurationsRepositoryImpl implements ClientPerfurationsRepository {
  ClientPerfurationsDataSources clientPerfurationsDataSources;

  ClientPerfurationsRepositoryImpl(this.clientPerfurationsDataSources);

  @override
  Future<Either<Failure, List<PerfurationEntity>>> readClientPerfurations(
      ReadClientPerfurationsParams params) async {
    try {
      return Right(
          await clientPerfurationsDataSources.readClientPerfurations(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteClientPerfuration(
      DeleteClientPerfurationParams params) async {
    try {
      return Right(
          await clientPerfurationsDataSources.deleteClientPerfuration(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
