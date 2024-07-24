import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/drawer/data/datasources/custom_drawer_datasources.dart';
import 'package:ariane_app/core/drawer/domain/usecases/fetch_user_session_usecase_impl.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';

class CustomDrawerDataSourcesImpl implements CustomDrawerDataSources {
  SessionStorage sessionStorage;

  CustomDrawerDataSourcesImpl(this.sessionStorage);
  @override
  Future<UserEntity> fetchUserSession(FetchUserSessionParams params) async {
    final UserEntity? session = await sessionStorage.fetchSession('session');

    if (session == null) {
      throw RemoteFailure(message: 'Nenhuma sessão encontrada!');
    }

    return session;
  }
}
