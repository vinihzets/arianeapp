import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/drawer/domain/usecases/fetch_user_session_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CustomDrawerRepository {
  Future<Either<Failure, UserEntity>> fetchUserSession(
      FetchUserSessionParams params);
}
