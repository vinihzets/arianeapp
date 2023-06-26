// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:ariane_app/core/failure/failure.dart';

abstract class UseCase<Input, Output> {
  Future<Either<Failure, Output>> call(Input params);
}

class NoParams {}

class SignInParams {
  String email;
  String password;

  SignInParams(this.email, this.password);
}

class SignUpParams {
  String email;
  String password;

  SignUpParams(this.email, this.password);
}

class CreateClientParams {
  final String firstName;
  final String lastName;
  final int number;
  final String birthday;

  CreateClientParams({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.birthday,
  });
}


class DeleteClientParams {
  final String id;
  DeleteClientParams({
    required this.id,
  });
}

class UpdateClientParams {
  final String firstName;
  final String lastName;
  final int number;
  final String birthday;
  final String id;
  UpdateClientParams({
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.birthday,
    required this.id,
  });
}


class CreateTypePerfurationParams{
    final String namePerfuration;
    final String id;

    CreateTypePerfurationParams({
required this.namePerfuration, required this.id
    });
}

class DeleteTypePerfurationParams{
  final String id;

  DeleteTypePerfurationParams({required this.id});
}

class UpdateTypePerfurationParams{
  final String namePerfuration;
  final String id;

  UpdateTypePerfurationParams({required this.namePerfuration, required this.id});

}
