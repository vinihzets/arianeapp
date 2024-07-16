import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';

class UserMapper extends EntityMapper<UserEntity> {
  @override
  UserEntity fromMap(Map<String, dynamic> map) {
    return UserEntity(email: map['email'], role: map['role']);
  }

  @override
  Map<String, dynamic> toMap(UserEntity entity) {
    return {
      'email': entity.email,
      'role': entity.role,
    };
  }
}
