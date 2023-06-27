import 'package:equatable/equatable.dart';

class PeriodEntity extends Equatable {
  final String name;
  final String message;
  final String id;
  final bool selected;
  final int? dayCounter;
  final int? monthCounter;
  final int? yearCounter;

  const PeriodEntity(
    this.dayCounter,
    this.monthCounter,
    this.yearCounter,
    this.selected, {
    required this.name,
    required this.message,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
