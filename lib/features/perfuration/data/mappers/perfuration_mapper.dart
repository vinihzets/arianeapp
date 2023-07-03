import 'package:ariane_app/core/architecture/mapper.dart';
import 'package:ariane_app/features/type_perfurations/data/data.dart';

import '../../../periods/data/mappers/period_mapper.dart';
import '../../domain/entities/perfuration_entity.dart';

class PerfurationMapper implements EntityMapper<PerfurationEntity> {
  late TypePerfurationMapper typePerfurationMapper;

  PerfurationMapper(this.typePerfurationMapper);

  @override
  PerfurationEntity fromMap(Map<String, dynamic> map) {
    return PerfurationEntity(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      listTypePerfuration:
          (map['type_perfuration'] as List).map((e) => typePerfurationMapper.fromMap(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toMap(PerfurationEntity entity) {
    return {
      'name': entity.name,
      'type_perfuration': entity.listTypePerfuration,
      'id': entity.id,
    };
  }
}
