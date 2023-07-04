import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/pending/domain/entities/pending_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PendingRepository {
  Future<Either<Failure, List<PendingEntity>>> getPendings({
    required DateTime date,
    required PendingEntity? startAfter,
    required int ammount,
  });
}
