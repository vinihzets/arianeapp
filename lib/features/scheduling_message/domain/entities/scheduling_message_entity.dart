import 'package:equatable/equatable.dart';

import '../../../clients/domain/entities/client_entity.dart';

class SchedulingMessageEntity extends Equatable {
  final List<ClientEntity> listClients;
  final String message;
  final DateTime date;
  final DateTime createdAt;

  SchedulingMessageEntity(
      {required this.listClients,
      required this.message,
      required this.date,
      required this.createdAt});

  @override
  List<Object?> get props => [createdAt];
}
