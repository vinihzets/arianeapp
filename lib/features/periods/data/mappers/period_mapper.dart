import 'package:ariane_app/core/architecture/mapper.dart';

import '../../../../core/global/entities/period_entity.dart';

class PeriodMapper implements EntityMapper<PeriodEntity> {
  @override
  PeriodEntity fromMap(Map<String, dynamic> map) {
    return PeriodEntity(
      dayCounter: map['dayCounter'],
      monthCounter: map['monthCounter'],
      yearCounter: map['yearCounter'],
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
      'dayCounter': entity.dayCounter,
      'monthCounter': entity.monthCounter,
      'yearCounter': entity.yearCounter,
    };
  }
}
