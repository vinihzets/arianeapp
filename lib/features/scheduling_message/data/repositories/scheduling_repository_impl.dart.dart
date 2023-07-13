import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/scheduling_message/domain/domain.dart';
import 'package:dartz/dartz.dart';
import '../datasources/scheduling_message_datasources.dart';

class SchedulingMessageRepositoryImpl implements SchedulingMessageRepository {
  SchedulingMessageDataSources dataSource;

  SchedulingMessageRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, SchedulingMessageEntity>> createSchedulingMessage(
      CreateSchedulingMessageParams params) async {
    try {
      return Right(
        await dataSource.createSchedulingMessage(
          params,
        ),
      );
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
