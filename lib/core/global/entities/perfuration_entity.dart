// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:equatable/equatable.dart';

class PerfurationEntity extends Equatable {
  final String clientId;
  final String clientName;
  final String id;
  final int createdAt;
  final TypePerfurationEntity typePerfuration;

  const PerfurationEntity({
    required this.clientId,
    required this.clientName,
    required this.id,
    required this.createdAt,
    required this.typePerfuration,
  });

  @override
  List<Object?> get props => [id];
}
