import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/pending/pending.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:dartz/dartz.dart';

class GetMessagesUseCaseImpl
    implements UseCase<GetMessagesParams, List<SchedulingMessageEntity>> {
  PendingRepository repository;

  GetMessagesUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<SchedulingMessageEntity>>> call(
      GetMessagesParams params) {
    return repository.getMessages(
      date: params.date,
    );
  }
}
