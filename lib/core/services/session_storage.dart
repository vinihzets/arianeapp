import 'package:ariane_app/features/users/domain/entities/user_entity.dart';

abstract class SessionStorage {
  Future<UserEntity>? fetchSession();

  Future<void> removeSession();

  Future<void> setSession(Map<String, dynamic> session);
}
