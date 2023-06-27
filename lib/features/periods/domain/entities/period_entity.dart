import 'package:equatable/equatable.dart';

class PeriodEntity extends Equatable {
  final String name;
  final String message;
  final String id;
  final int? dayCounter;
  final int? monthCounter;
  final int? yearCounter;

  const PeriodEntity(
    this.dayCounter,
    this.monthCounter,
    this.yearCounter, {
    required this.name,
    required this.message,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
