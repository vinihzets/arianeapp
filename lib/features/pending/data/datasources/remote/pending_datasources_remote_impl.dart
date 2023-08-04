import 'package:ariane_app/core/core.dart';

import 'package:ariane_app/features/pending/data/data.dart';
import 'package:ariane_app/features/scheduling_message/data/mappers/scheduling_message_mapper.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';

import '../../../domain/entities/pending_entity.dart';

class PendingDataSourceRemoteImpl implements PendingDataSource {
  DatabaseService databaseService;
  PendingMapper mapper;
  SchedulingMessageMapper messageMapper;

  PendingDataSourceRemoteImpl(
    this.databaseService,
    this.mapper,
    this.messageMapper,
  );

  @override
  Future<List<PendingEntity>> getPendings({
    required DateTime date,
    required PendingEntity? startAfter,
    required int ammount,
  }) async {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 24, 0);

    final query = databaseService.pendings.orderBy('date').where(
          'date',
          isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch,
          isLessThanOrEqualTo: endOfDay.millisecondsSinceEpoch,
        );

    if (startAfter != null) {
      query.startAfter([startAfter.date.millisecondsSinceEpoch]);
    }

    final request = await query.get();

    return request.docs.map((e) => mapper.fromMap(e.data())).toList();
  }

  @override
  Future<List<SchedulingMessageEntity>> getMessages({
    required DateTime date,
  }) async {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59);

    final messages = await databaseService.schedulingMessages
        .where(
          'date',
          isGreaterThanOrEqualTo: startOfDay.millisecondsSinceEpoch,
          isLessThanOrEqualTo: endOfDay.millisecondsSinceEpoch,
        )
        .get();

    return messages.docs.map((e) => messageMapper.fromMap(e.data())).toList();
  }
}
