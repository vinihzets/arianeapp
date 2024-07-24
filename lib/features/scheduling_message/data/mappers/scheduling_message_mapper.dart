import 'package:ariane_app/core/architecture/mapper.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';

class SchedulingMessageMapper extends EntityMapper<SchedulingMessageEntity> {
  ClientMapper mapper;

  SchedulingMessageMapper(this.mapper);

  @override
  SchedulingMessageEntity fromMap(dynamic map) {
    return SchedulingMessageEntity(
      message: map["message"] ?? '',
      listClients:
          (map["listClients"] as List).map((e) => mapper.fromMap(e)).toList(),
      date: DateTime.fromMillisecondsSinceEpoch(map["date"]),
      id: map["id"] ?? '',
      createdAt: map["createdAt"],
      sent: map['sent'] ?? false,
      userId: map['userId'],
    );
  }

  @override
  Map<String, dynamic> toMap(SchedulingMessageEntity entity) {
    return {
      "message": entity.message,
      "listClients": (entity.listClients).map((e) => mapper.toMap(e)).toList(),
      "date": entity.date.millisecondsSinceEpoch,
      "createdAt": entity.createdAt,
      'id': entity.id,
      'sent': entity.sent,
      'userId': entity.userId,
    };
  }
}
