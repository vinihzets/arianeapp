import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:ariane_app/features/scheduling_message/domain/repositories/scheduling_message_repository.dart';
import 'package:dartz/dartz.dart';

class CreateSchedulingMessageUseCaseImpl
    implements UseCase<CreateSchedulingMessageParams, SchedulingMessageEntity> {
  SchedulingMessageRepository repository;

  CreateSchedulingMessageUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, SchedulingMessageEntity>> call(
      CreateSchedulingMessageParams params) {
    return repository.createSchedulingMessage(params);
  }
}
