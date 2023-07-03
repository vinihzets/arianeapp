import 'package:ariane_app/core/architecture/mapper.dart';

import '../../../features/periods/data/mappers/period_mapper.dart';
import '../entities/type_perfuration_entity.dart';

class TypePerfurationMapper implements EntityMapper<TypePerfurationEntity> {
  late PeriodMapper periodMapper;

  TypePerfurationMapper(this.periodMapper);

  @override
  TypePerfurationEntity fromMap(Map<String, dynamic> map) {
    return TypePerfurationEntity(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      listPeriods:
          (map['periods'] as List).map((e) => periodMapper.fromMap(e)).toList(),
    );
  }

  @override
  Map<String, dynamic> toMap(TypePerfurationEntity entity) {

      final List<Map<String, dynamic>> periodsMap = entity.listPeriods
      .map((period) => periodMapper.toMap(period))
      .toList();

    return {
      'name': entity.name,
      'periods': periodsMap,
      'id': entity.id,
      
    };
  }
}
