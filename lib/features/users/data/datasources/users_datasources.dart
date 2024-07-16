import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';

abstract class UsersDataSources {
  Future<dynamic> fetchUsers(FetchUsersParams params);
}
