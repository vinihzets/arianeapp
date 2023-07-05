import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String number;
  final String birthday;
  final String id;

  const ClientEntity({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.birthday,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
