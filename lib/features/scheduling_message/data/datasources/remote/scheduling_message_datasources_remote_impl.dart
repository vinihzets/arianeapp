import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
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
  SessionStorage sessionStorage;

  SchedulingMessageDataSourcesRemoteImpl(
    this.mapper,
    this.clientMapper,
    this.databaseService,
    this.sessionStorage,
  );

  @override
  Future<SchedulingMessageEntity> createSchedulingMessage(
    CreateSchedulingMessageParams params,
  ) async {
    final doc = databaseService.schedulingMessages.doc();
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception();
    }

    final entity = SchedulingMessageEntity(
      message: params.message,
      listClients: params.listClients,
      id: doc.id,
      date: params.date,
      createdAt: params.createdAt,
      sent: false,
      userId: session.id,
    );

    await doc.set(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<List<SchedulingMessageEntity>> readSchedulingsMessages(
      ReadSchedulingMessagesParams params) async {
    final user = await sessionStorage.fetchSession();

    if (user == null) {
      throw RemoteFailure(message: 'Nenhum usuário logado');
    }

    var query = databaseService.schedulingMessages
        .where('userId', isEqualTo: user.id)
        .orderBy('createdAt', descending: true);

    if (params.last != null) {
      query = query.startAfter([params.last!.createdAt]);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((e) => mapper.fromMap(e.data())).toList();
  }

  @override
  Future<SchedulingMessageEntity> updateSchedulingMessage(
    UpdateSchedulingMessageParams params,
  ) async {
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception();
    }

    final entity = SchedulingMessageEntity(
      message: params.message,
      listClients: params.listClients,
      id: params.id,
      date: params.date,
      createdAt: params.createdAt,
      sent: params.sent,
      userId: session.id,
    );

    await databaseService.schedulingMessages
        .doc(entity.id)
        .update(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<void> deleteSchedulingMessage(
      DeleteSchedulingMessageParams params) async {
    return databaseService.schedulingMessages.doc(params.id).delete();
  }

  @override
  Future<List<ClientEntity>> getClients(GetClientsParams params) async {
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception();
    }
    final clients = databaseService.clients
        .where('userId', isEqualTo: session.id)
        .limit(params.ammount);

    Query query = clients;

    if (params.startAfter != null) {
      query = query.orderBy('id').startAfter([params.startAfter!.id]);
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return clientMapper.fromMap(data);
    }).toList();
  }

  @override
  Future<List<ClientEntity>> searchClient(SearchClientParams params) async {
    final query = await databaseService.clients
        .orderBy('completeSearchName')
        .startAt([params.query]).endAt(["${params.query}\uf8ff"]).get();

    final clients =
        query.docs.map((e) => clientMapper.fromMap(e.data())).toList();

    return clients;
  }
}
