import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/scheduling_message/data/data.dart';
import 'package:ariane_app/features/scheduling_message/domain/domain.dart';

class SchedulingMessageDataSourcesRemoteImpl
    implements SchedulingMessageDataSources {
  DatabaseService databaseService;
  SchedulingMessageMapper mapper;

  SchedulingMessageDataSourcesRemoteImpl(this.databaseService, this.mapper);

  @override
  Future<SchedulingMessageEntity> createSchedulingMessage(
      CreateSchedulingMessageParams params) async {
    final entity = SchedulingMessageEntity(
        listClients: params.listClients,
        message: params.message,
        date: params.date,
        createdAt: params.createdAt);

    await databaseService.schedulingMessages.add(mapper.toMap(entity));

    return entity;
  }
}
