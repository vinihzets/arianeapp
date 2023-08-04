import 'package:ariane_app/features/pending/domain/entities/pending_entity.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';

abstract class PendingDataSource {
  Future<List<PendingEntity>> getPendings({
    required DateTime date,
    required PendingEntity? startAfter,
    required int ammount,
  });
  Future<List<SchedulingMessageEntity>> getMessages({
    required DateTime date,
  });
}
