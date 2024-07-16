import 'package:ariane_app/core/drawer/domain/usecases/fetch_user_session_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';

abstract class CustomDrawerDataSources {
  Future<UserEntity> fetchUserSession(FetchUserSessionParams params);
}
