import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/scheduling_message/data/datasources/scheduling_message_datasources.dart';
import 'package:ariane_app/features/scheduling_message/data/mappers/scheduling_message_mapper.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulingMessageDataSourcesRemoteImpl
    implements SchedulingMessageDataSources {
  SchedulingMessageMapper mapper;
  ClientMapper clientMapper;
  DatabaseService databaseService;

  SchedulingMessageDataSourcesRemoteImpl(
      this.mapper, this.clientMapper, this.databaseService);

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

    return messages.docs.map((e) => mapper.fromMap(e.data())).toList();
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

  @override
  Future<List<ClientEntity>> getClients(GetClientsParams params) async {
    final clients = databaseService.clients.limit(params.ammount);

    Query query = clients;

    if (params.startAfter != null) {
      query =
          query.orderBy('firstName').startAfter([params.startAfter!.firstName]);
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return clientMapper.fromMap(data);
    }).toList();
  }
}
