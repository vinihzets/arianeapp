import 'package:equatable/equatable.dart';

import 'period_entity.dart';

class TypePerfurationEntity extends Equatable {
  final String name;
  final String id;
  final List<PeriodEntity> listPeriods;

  final String userId;

  const TypePerfurationEntity({
    required this.name,
    required this.id,
    required this.listPeriods,
    required this.userId,
  });

  @override
  List<Object?> get props => [id];
}
