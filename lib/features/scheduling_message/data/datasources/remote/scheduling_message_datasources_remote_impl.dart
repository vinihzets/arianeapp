import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/scheduling_message/data/datasources/scheduling_message_datasources.dart';
import 'package:ariane_app/features/scheduling_message/data/mappers/scheduling_message_mapper.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';

class SchedulingMessageDataSourcesRemoteImpl
    implements SchedulingMessageDataSources {
  SchedulingMessageMapper mapper;
  DatabaseService databaseService;

  SchedulingMessageDataSourcesRemoteImpl(this.mapper, this.databaseService);

  @override
  Future<SchedulingMessageEntity> createSchedulingMessage(
      CreateSchedulingMessageParams params) async {
    final doc = databaseService.schedulingMessages.doc();

    final entity = SchedulingMessageEntity(
        message: params.message,
        listClients: params.listClients,
        id: doc.id,
        date: params.date,
        createdAt: params.createdAt);

    await doc.set(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<List<SchedulingMessageEntity>> readSchedulingsMessages() async {
    final messages = await databaseService.schedulingMessages.get();

    return messages.docs.map(mapper.fromMap).toList();
  }

  @override
  Future<SchedulingMessageEntity> updateSchedulingMessage(
      UpdateSchedulingMessageParams params) async {
    final entity = SchedulingMessageEntity(
        message: params.message,
        listClients: params.listClients,
        id: params.id,
        date: params.date,
        createdAt: params.createdAt);

    await databaseService.schedulingMessages
        .doc(entity.id)
        .update(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<void> deleteSchedulingMessage(DeleteSchedulingMessageParams params) {
    return databaseService.schedulingMessages.doc(params.id).delete();
  }
}
