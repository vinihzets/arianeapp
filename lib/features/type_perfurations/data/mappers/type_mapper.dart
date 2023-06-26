import 'package:ariane_app/core/architecture/mapper.dart';

import '../../domain/entities/type_entity.dart';

class TypePerfurationMapper implements EntityMapper<TypePerfurationEntity> {
  @override
  TypePerfurationEntity fromMap(Map<String, dynamic> map) {
    return TypePerfurationEntity(
    namePerfuration: map['namePerfuration'],
      id: map['id'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap(TypePerfurationEntity entity) {
    return {
      'namePerfuration': entity.namePerfuration,
      'id': entity.id,

    };
  }
}
