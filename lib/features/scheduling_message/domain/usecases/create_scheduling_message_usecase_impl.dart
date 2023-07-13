import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/scheduling_message/domain/domain.dart';
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
