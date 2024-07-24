import 'package:ariane_app/core/architecture/mapper.dart';

import '../../../../core/global/entities/period_entity.dart';

class PeriodMapper implements EntityMapper<PeriodEntity> {
  @override
  PeriodEntity fromMap(Map<String, dynamic> map) {
    return PeriodEntity(
      dayCounter: map['day'],
      monthCounter: map['month'],
      yearCounter: map['year'],
      name: map['name'],
      message: map['message'],
      id: map['id'],
      userId: map['userId'],
    );
  }

  @override
  Map<String, dynamic> toMap(PeriodEntity entity) {
    return {
      'id': entity.id,
      'name': entity.name,
      'message': entity.message,
      'day': entity.dayCounter,
      'month': entity.monthCounter,
      'year': entity.yearCounter,
      'userId': entity.userId,
    };
  }
}
