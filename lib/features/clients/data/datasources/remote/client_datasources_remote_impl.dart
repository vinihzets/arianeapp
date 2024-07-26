import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/clients/data/datasources/client_datasources.dart';
import 'package:ariane_app/features/clients/data/mappers/client_mapper.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDataSourcesRemoteImpl implements ClientDataSources {
  DatabaseService databaseService;
  ClientMapper mapper;
  SessionStorage storage;

  ClientDataSourcesRemoteImpl(
    this.databaseService,
    this.mapper,
    this.storage,
  );

  @override
  Future<ClientEntity> createClient(CreateClientParams params) async {
    final doc = databaseService.clients.doc();

    final entity = ClientEntity(
      firstName: params.firstName,
      lastName: params.lastName,
      number: params.number,
      birthday: params.birthday,
      id: doc.id,
      userId: params.userId,
    );

    await doc.set(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<List<ClientEntity>> readClient(GetClientsParams params) async {
    final user = await storage.fetchSession();

    if (user == null) {
      throw RemoteFailure(message: 'Nenhum usuário logado');
    }

    final clients = databaseService.clients
        .where('userId', isEqualTo: user.id)
        .limit(params.ammount);

    Query query = clients;

    if (params.startAfter != null) {
      query = query.orderBy('id').startAfter([
        params.startAfter!.id,
      ]);
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return mapper.fromMap(data);
    }).toList();
  }

  @override
  Future deleteClient(DeleteClientParams params) async {
    return await databaseService.clients.doc(params.id).delete();
  }

  @override
  Future<ClientEntity> updateClient(UpdateClientParams params) async {
    final entity = ClientEntity(
      firstName: params.firstName,
      lastName: params.lastName,
      number: params.number,
      birthday: params.birthday,
      id: params.id,
      userId: params.userId,
    );

    await databaseService.clients.doc(params.id).update(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<List<ClientEntity>> searchClient(SearchClientParams params) async {
    final user = await storage.fetchSession();

    if (user == null) {
      throw RemoteFailure(message: 'Nenhum usuário logado');
    }
    final query = await databaseService.clients
        .where('userId', isEqualTo: user.id)
        .orderBy('completeSearchName')
        .startAt([params.query]).endAt(["${params.query}\uf8ff"]).get();

    final clients = query.docs.map((e) => mapper.fromMap(e.data())).toList();

    return clients;
  }
}
