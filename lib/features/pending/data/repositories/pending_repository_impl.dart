import 'package:ariane_app/core/failure/failure.dart';

import 'package:ariane_app/features/pending/domain/entities/pending_entity.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/pending_repository.dart';
import '../datasources/pending_datasources.dart';

class PendingRepositoryImpl implements PendingRepository {
  PendingDataSource dataSource;

  PendingRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<PendingEntity>>> getPendings({
    required DateTime date,
    required PendingEntity? startAfter,
    required int ammount,
  }) async {
    try {
      return Right(
        await dataSource.getPendings(
          date: date,
          startAfter: startAfter,
          ammount: ammount,
        ),
      );
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SchedulingMessageEntity>>> getMessages({
    required DateTime date,
  }) async {
    try {
      return Right(
        await dataSource.getMessages(
          date: date,
        ),
      );
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
