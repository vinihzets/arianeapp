import 'package:ariane_app/core/architecture/mapper.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';

class SchedulingMessageMapper extends EntityMapper<SchedulingMessageEntity> {
  late ClientMapper mapper;

  @override
  SchedulingMessageEntity fromMap(dynamic map) {
    return SchedulingMessageEntity(
        message: map["message"],
        listClients: map["listClients"],
        date: map["date"],
        id: map["id"],
        createdAt: map["createdAt"]);
  }

  @override
  Map<String, dynamic> toMap(SchedulingMessageEntity entity) {
    return {
      "message": entity.message,
      "listClients": (entity.listClients).map((e) => mapper.toMap(e)).toList(),
      "date": entity.date,
      "createdAt": entity.createdAt,
    };
  }
}
