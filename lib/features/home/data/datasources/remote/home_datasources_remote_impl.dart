import 'package:ariane_app/core/services/auth_service.dart';
import 'package:ariane_app/features/home/data/datasources/home_datasources.dart';

class HomeDataSourcesRemoteImpl implements HomeDataSources {
  AuthService authService;

  HomeDataSourcesRemoteImpl(this.authService);

  @override
  Future<void> signOut() {
    return authService.auth.signOut();
  }
}
