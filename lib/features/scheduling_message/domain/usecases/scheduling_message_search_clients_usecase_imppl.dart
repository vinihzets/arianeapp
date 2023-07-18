import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:ariane_app/features/scheduling_message/domain/repositories/scheduling_message_repository.dart';
import 'package:dartz/dartz.dart';

class SchedulingMessageSearchClientsUseCaseImpl
    implements UseCase<SearchClientParams, List<ClientEntity>> {
  SchedulingMessageRepository repository;

  SchedulingMessageSearchClientsUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<ClientEntity>>> call(SearchClientParams params) {
    return repository.searchClient(params);
  }
}
