import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/scheduling_message/domain/repositories/scheduling_message_repository.dart';
import 'package:dartz/dartz.dart';

class GetClientsUseCaseImpl
    implements UseCase<GetClientsParams, List<ClientEntity>> {
  SchedulingMessageRepository repository;

  GetClientsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<ClientEntity>>> call(GetClientsParams params) {
    return repository.getClients(params);
  }
}
