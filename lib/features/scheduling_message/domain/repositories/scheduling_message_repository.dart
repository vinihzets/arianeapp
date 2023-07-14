import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SchedulingMessageRepository {
  Future<Either<Failure, List<SchedulingMessageEntity>>>
      readSchedulingsMessages();
  Future<Either<Failure, SchedulingMessageEntity>> createSchedulingMessage(
      CreateSchedulingMessageParams params);
  Future<Either<Failure, SchedulingMessageEntity>> updateSchedulingMessage(
      UpdateSchedulingMessageParams params);
  Future<Either<Failure, void>> deleteSchedulingMessage(
      DeleteSchedulingMessageParams params);
}
