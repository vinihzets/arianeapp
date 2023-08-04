import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/client_perfurations/domain/repositories/client_perfurations_repository.dart';
import 'package:dartz/dartz.dart';

class ReadClientPerfurationsUseCaseImpl
    implements UseCase<ReadClientPerfurationsParams, List<PerfurationEntity>> {
  ClientPerfurationsRepository clientPerfurationsRepository;

  ReadClientPerfurationsUseCaseImpl(this.clientPerfurationsRepository);

  @override
  Future<Either<Failure, List<PerfurationEntity>>> call(
      ReadClientPerfurationsParams params) {
    return clientPerfurationsRepository.readClientPerfurations(params);
  }
}
