import 'package:ariane_app/core/architecture/mapper.dart';
import 'package:ariane_app/features/type_perfurations/data/data.dart';
import '../entities/perfuration_entity.dart';

class PerfurationMapper implements EntityMapper<PerfurationEntity> {
  late TypePerfurationMapper typePerfurationMapper;

  PerfurationMapper(this.typePerfurationMapper);

  @override
  PerfurationEntity fromMap(Map<String, dynamic> map) {
    return PerfurationEntity(
      clientId: map['clientId'],
      clientName: map['clientName'],
      clientNumber: map['clientNumber'],
      createdAt: map['createdAt'],
      id: map['id'],
      typePerfuration: typePerfurationMapper.fromMap(map['type_perfuration']),
      userId: map['userId'],
    );
  }

  @override
  Map<String, dynamic> toMap(PerfurationEntity entity) {
    return {
      'clientName': entity.clientName,
      'clientId': entity.clientId,
      'clientNumber': entity.clientNumber,
      'createdAt': entity.createdAt,
      'type_perfuration': typePerfurationMapper.toMap(entity.typePerfuration),
      'userId': entity.userId,
      'id': entity.id,
    };
  }
}
