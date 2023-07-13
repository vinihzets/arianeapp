import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/scheduling_message/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class SchedulingMessageRepository {
  Future<Either<Failure, SchedulingMessageEntity>> createSchedulingMessage(
      CreateSchedulingMessageParams params);
}
