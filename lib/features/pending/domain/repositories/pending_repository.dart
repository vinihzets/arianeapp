import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/pending/domain/entities/pending_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../scheduling_message/domain/entities/scheduling_message_entity.dart';

abstract class PendingRepository {
  Future<Either<Failure, List<PendingEntity>>> getPendings({
    required DateTime date,
    required PendingEntity? startAfter,
    required int ammount,
  });

  Future<Either<Failure, List<SchedulingMessageEntity>>> getMessages({
    required DateTime date,
  });
}
