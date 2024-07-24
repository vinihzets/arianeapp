import 'package:ariane_app/core/core.dart';
import 'package:equatable/equatable.dart';

class PendingEntity extends Equatable {
  final String id;
  final String clientName;
  final String clientId;
  final String clientNumber;

  final DateTime date;
  final String message;
  final bool sent;

  final TypePerfurationEntity typePerfuration;
  final PeriodEntity period;

  const PendingEntity({
    required this.id,
    required this.clientName,
    required this.clientId,
    required this.clientNumber,
    required this.date,
    required this.message,
    required this.sent,
    required this.period,
    required this.typePerfuration,
  });

  @override
  List<Object?> get props => [id];
}
