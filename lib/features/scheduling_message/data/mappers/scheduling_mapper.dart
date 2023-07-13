import 'package:ariane_app/core/architecture/mapper.dart';

import '../../domain/entities/scheduling_message_entity.dart';

class SchedulingMessageMapper implements EntityMapper<SchedulingMessageEntity> {
  @override
  SchedulingMessageEntity fromMap(Map<String, dynamic> map) {
    return SchedulingMessageEntity(
        listClients: map['listClients'],
        message: map['message'],
        date: map['date'],
        createdAt: map['createdAt']);
  }

  @override
  Map<String, dynamic> toMap(SchedulingMessageEntity entity) {
    return {
      'listClients': entity.listClients,
      'message': entity.message,
      'date': entity.date,
      'createdAt': entity.createdAt,
    };
  }
}
