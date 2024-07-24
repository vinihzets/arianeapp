import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/users/data/datasources/users_datasources.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/repositories/users_repository.dart';
import 'package:ariane_app/features/users/domain/usecases/update_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/create_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';
import 'package:dartz/dartz.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersDataSources dataSources;

  UsersRepositoryImpl(this.dataSources);

  @override
  Future<Either<Failure, dynamic>> fetchUsers(FetchUsersParams params) async {
    try {
      return Right(await dataSources.fetchUsers(params));
    } on RemoteFailure catch (ex) {
      return Left(RemoteFailure(message: ex.message));
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUser(
      CreateUserParams params) async {
    try {
      return Right(await dataSources.createUser(params));
    } on RemoteFailure catch (ex) {
      return Left(RemoteFailure(message: ex.message));
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UpdateUserParams params) async {
    try {
      return Right(await dataSources.updateUser(params));
    } on RemoteFailure catch (ex) {
      return Left(RemoteFailure(message: ex.message));
    } catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
