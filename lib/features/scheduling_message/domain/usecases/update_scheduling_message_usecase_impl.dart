import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:ariane_app/features/scheduling_message/domain/repositories/scheduling_message_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateSchedulingMessageUseCaseImpl
    implements UseCase<UpdateSchedulingMessageParams, SchedulingMessageEntity> {
  SchedulingMessageRepository repository;

  UpdateSchedulingMessageUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, SchedulingMessageEntity>> call(
      UpdateSchedulingMessageParams params) async {
    return repository.updateSchedulingMessage(params);
  }
}
