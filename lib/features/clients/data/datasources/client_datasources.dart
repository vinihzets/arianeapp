import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/features/clients/data/mappers/client_mapper.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';

abstract class ClientDataSources {
  Future<ClientEntity> createClient(CreateClientParams entity);
  Future<List<ClientEntity>> readClient();
  Future<void> deleteClient(DeleteClientParams entity);
  Future<ClientEntity> updateClient(UpdateClientParams params);
}
