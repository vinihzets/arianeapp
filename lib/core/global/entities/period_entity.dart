import 'package:equatable/equatable.dart';

class PeriodEntity extends Equatable {
  final String name;
  final String message;
  final String id;

  final int dayCounter;
  final int monthCounter;
  final int yearCounter;

  final String userId;

  const PeriodEntity({
    required this.name,
    required this.message,
    required this.id,
    required this.dayCounter,
    required this.monthCounter,
    required this.yearCounter,
    required this.userId,
  });

  @override
  List<Object?> get props => [id];
}
