import 'package:ariane_app/features/users/domain/entities/user_entity.dart';

abstract class SessionStorage {
  Future<UserEntity>? fetchSession(String key);

  Future<void> removeSession(String key);

  Future<void> setSession(String key, Map<String, dynamic> session);
}
