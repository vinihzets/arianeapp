import 'package:ariane_app/core/architecture/mapper.dart';
import 'package:ariane_app/features/pending/domain/domain.dart';

class PendingMapper implements EntityMapper<PendingEntity> {
  @override
  PendingEntity fromMap(Map<String, dynamic> map) {
    return PendingEntity(
      id: map['id'],
      clientName: map['clientName'],
      clientId: map['clientId'],
      message: map['message'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      sent: map['sent'],
    );
  }

  @override
  Map<String, dynamic> toMap(PendingEntity entity) {
    return {
      'id': entity.id,
      'clientName': entity.clientName,
      'clientId': entity.clientId,
      'message': entity.message,
      'date': entity.date.millisecondsSinceEpoch,
      'sent': entity.sent
    };
  }
}
