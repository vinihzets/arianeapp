import 'package:ariane_app/core/architecture/mapper.dart';

import '../../domain/entities/client_entity.dart';

class ClientMapper implements EntityMapper<ClientEntity> {
  @override
  ClientEntity fromMap(Map<String, dynamic> map) {
    return ClientEntity(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      number: map['number'] ?? 0,
      birthday: map['birthday'] ?? '',
      id: map['id'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap(ClientEntity entity) {
    return {
      'id': entity.id,
      'firstName': entity.firstName,
      'lastName': entity.lastName,
      'number': entity.number,
      'birthday': entity.birthday,
    };
  }
}
