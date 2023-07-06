import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/clients/data/datasources/client_datasources.dart';
import 'package:ariane_app/features/clients/data/mappers/client_mapper.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDataSourcesRemoteImpl implements ClientDataSources {
  DatabaseService databaseService;
  ClientMapper mapper;

  ClientDataSourcesRemoteImpl(this.databaseService, this.mapper);

  @override
  Future<ClientEntity> createClient(CreateClientParams params) async {
    final doc = databaseService.clients.doc();

    final entity = ClientEntity(
      firstName: params.firstName,
      lastName: params.lastName,
      number: params.number,
      birthday: params.birthday,
      id: doc.id,
    );

    await doc.set(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<List<ClientEntity>> readClient(GetClientsParams params) async {
    final clients = databaseService.clients.limit(params.ammount);

    Query query = clients;

    if (params.startAfter != null) {
      query =
          query.orderBy('firstName').startAfter([params.startAfter!.firstName]);
    }

    final querySnapshot = await query.get();

    final listClients = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return mapper.fromMap(data);
    }).toList();

    return listClients;
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
        id: params.id);

    await databaseService.clients.doc(params.id).update(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<List<ClientEntity>> searchClient(SearchClientParams params) async {
    final query = await databaseService.clients
        .orderBy('completeSearchName')
        .startAt([params.query]).endAt(["${params.query}\uf8ff"]).get();

    final clients = query.docs.map((e) => mapper.fromMap(e.data())).toList();

    return clients;
  }
}
