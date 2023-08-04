import 'package:ariane_app/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class ClientPerfurationsRepository {
  Future<Either<Failure, List<PerfurationEntity>>> readClientPerfurations(
      ReadClientPerfurationsParams params);
  Future<Either<Failure, void>> deleteClientPerfuration(
      DeleteClientPerfurationParams params);
}
