import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';

abstract class SchedulingMessageDataSources {
  Future<List<SchedulingMessageEntity>> readSchedulingsMessages();
  Future<SchedulingMessageEntity> createSchedulingMessage(
      CreateSchedulingMessageParams params);
  Future<void> deleteSchedulingMessage(DeleteSchedulingMessageParams params);
  Future<SchedulingMessageEntity> updateSchedulingMessage(
      UpdateSchedulingMessageParams params);
  Future<List<ClientEntity>> getClients(GetClientsParams params);
  Future<List<ClientEntity>> searchClient(SearchClientParams params);
}
