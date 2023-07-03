// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/global/entities/period_entity.dart';

class PerfurationEntity extends Equatable {
  final String name;
  final String id;
  final List<TypePerfurationEntity> listTypePerfuration;

  const PerfurationEntity({
    required this.name,
    required this.id,
    required this.listTypePerfuration,
  });

  @override
  List<Object?> get props => [id];
}
