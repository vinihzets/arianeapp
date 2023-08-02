import 'package:ariane_app/features/clients/clients.dart';

class SchedulingMessageEntity {
  final String message;
  final List<ClientEntity> listClients;
  final String id;
  final DateTime date;
  final String createdAt;

  SchedulingMessageEntity({
    required this.message,
    required this.listClients,
    required this.id,
    required this.date,
    required this.createdAt,
  });
}
