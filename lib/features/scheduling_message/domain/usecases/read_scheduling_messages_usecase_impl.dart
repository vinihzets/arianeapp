import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/scheduling_message/domain/repositories/scheduling_message_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/scheduling_message_entity.dart';

class ReadSchedulingMessagesUseCaseImpl
    implements
        UseCase<ReadSchedulingMessagesParams, List<SchedulingMessageEntity>> {
  SchedulingMessageRepository repository;

  ReadSchedulingMessagesUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<SchedulingMessageEntity>>> call(
    ReadSchedulingMessagesParams params,
  ) async {
    return repository.readSchedulingsMessages(params);
  }
}
