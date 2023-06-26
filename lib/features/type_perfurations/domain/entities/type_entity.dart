import 'package:equatable/equatable.dart';

class TypePerfurationEntity extends Equatable {
  final String namePerfuration;
  final String id;

  const TypePerfurationEntity({

    required this.namePerfuration,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
