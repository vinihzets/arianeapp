import 'package:equatable/equatable.dart';

class PendingEntity extends Equatable {
  final String id;
  final String clientName;
  final String clientId;

  final DateTime date;
  final String message;
  final bool sent;

  const PendingEntity({
    required this.id,
    required this.clientName,
    required this.clientId,
    required this.date,
    required this.message,
    required this.sent,
  });

  @override
  List<Object?> get props => [id];
}
