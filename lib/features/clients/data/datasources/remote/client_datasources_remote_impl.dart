import 'dart:developer';

import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/clients/data/datasources/client_datasources.dart';
import 'package:ariane_app/features/clients/data/mappers/client_mapper.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';

class ClientDataSourcesRemoteImpl implements ClientDataSources {
  DatabaseService databaseService;
  ClientMapper mapper;

  ClientDataSourcesRemoteImpl(this.databaseService, this.mapper);

  @override
  Future<ClientEntity> createClient(CreateClientParams params) async {
    final doc = databaseService.clients.doc();

    await doc.set({
      'id': doc.id,
      'firstName': params.firstName,
      'lastName': params.lastName,
      'number': params.number,
      'birthday': params.birthday,
    });

    return ClientEntity(
      firstName: params.firstName,
      lastName: params.lastName,
      number: params.number,
      birthday: params.birthday,
      id: doc.id,
    );
  }

  @override
  Future<List<ClientEntity>> readClient() async {
    final clients = await databaseService.clients.get();

    final List<ClientEntity> listClients = clients.docs
        .map(
          (e) => mapper.fromMap(e.data()),
        )
        .toList();

    return listClients;
  }

  @override
  Future deleteClient(DeleteClientParams params) async {
    return await databaseService.clients.doc(params.id).delete();
  }

  @override
  Future<ClientEntity> updateClient(UpdateClientParams params) async {
    await databaseService.clients.doc(params.id).update({
      'firstName': params.firstName,
      'lastName': params.lastName,
      'number': params.number,
      'birthday': params.birthday,
    });

    return ClientEntity(
        firstName: params.firstName,
        lastName: params.lastName,
        number: params.number,
        birthday: params.birthday,
        id: params.id);
  }
}
