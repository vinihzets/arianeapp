import 'package:equatable/equatable.dart';

class ClientEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String number;
  final String birthday;
  final String id;
  final String userId;

  const ClientEntity({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.birthday,
    required this.userId,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
