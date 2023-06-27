import 'package:ariane_app/core/architecture/mapper.dart';

import '../../domain/entities/period_entity.dart';

class PeriodMapper implements EntityMapper<PeriodEntity> {
  @override
  PeriodEntity fromMap(Map<String, dynamic> map) {
    return PeriodEntity(
      map['day'],
      map['month'],
      map['year'],
      map['selected'],
      name: map['name'],
      message: map['message'],
      id: map['id'],
    );
  }

  @override
  Map<String, dynamic> toMap(PeriodEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'message': entity.message,
      'selected': false,
    };
  }
}
