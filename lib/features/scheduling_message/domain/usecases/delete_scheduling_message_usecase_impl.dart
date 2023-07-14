import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/scheduling_message/domain/repositories/scheduling_message_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteSchedulingMessageUseCaseImpl
    implements UseCase<DeleteSchedulingMessageParams, void> {
  SchedulingMessageRepository repository;

  DeleteSchedulingMessageUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteSchedulingMessageParams params) {
    return repository.deleteSchedulingMessage(params);
  }
}
