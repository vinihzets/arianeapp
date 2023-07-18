// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ariane_app/features/clients/clients.dart';
import 'package:dartz/dartz.dart';

import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';

import '../../features/pending/pending.dart';
import '../global/entities/period_entity.dart';

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
  final String number;
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
  final String number;
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

class GetClientsParams {
  int ammount;
  ClientEntity? startAfter;
  GetClientsParams(this.ammount, this.startAfter);
}

class GetMoreClientsParams {
  int ammount;
  ClientEntity? startAfter;

  GetMoreClientsParams(this.ammount, this.startAfter);
}

class CreateTypePerfurationParams {
  final String name;
  final String id;
  final List<PeriodEntity> periods;

  CreateTypePerfurationParams(
      {required this.name, required this.id, required this.periods});
}

class DeleteTypePerfurationParams {
  final String id;

  DeleteTypePerfurationParams({required this.id});
}

class UpdateTypePerfurationParams {
  final String name;
  final String id;
  final List<PeriodEntity> listPeriods;

  UpdateTypePerfurationParams(
      {required this.name, required this.id, required this.listPeriods});
}

class CreatePeriodParams {
  final String name;
  final int dayCounter;
  final int monthCounter;
  final int yearCounter;
  final String message;

  CreatePeriodParams({
    required this.name,
    required this.dayCounter,
    required this.monthCounter,
    required this.yearCounter,
    required this.message,
  });
}

class DeletePeriodParams {
  final String id;

  DeletePeriodParams({required this.id});
}

class UpdatePeriodParams {
  final String name;
  final String message;
  final String id;
  final int dayCounter;
  final int monthCounter;
  final int yearCounter;

  UpdatePeriodParams(this.dayCounter, this.monthCounter, this.yearCounter,
      {required this.name, required this.message, required this.id});
}

class CreatePerfurationParams {
  final String clientName;
  final String clientId;
  final TypePerfurationEntity typePerfurationEntity;

  CreatePerfurationParams(
      {required this.clientName,
      required this.clientId,
      required this.typePerfurationEntity});
}

class DeletePerfurationParams {
  final String id;

  DeletePerfurationParams({required this.id});
}

class UpdatePerfurationParams {
  final String name;
  final String id;

  UpdatePerfurationParams({
    required this.name,
    required this.id,
  });
}

class ReadPerfurationParams {}

class GetPendingsParams {
  final DateTime date;
  final PendingEntity? startAfter;
  final int ammount;

  GetPendingsParams({
    required this.date,
    required this.startAfter,
    required this.ammount,
  });
}

class SearchClientParams {
  String query;

  SearchClientParams({required this.query});
}

class ReadSchedulingMessagesParams {
  final int ammount;
  final DateTime date;

  ReadSchedulingMessagesParams({required this.ammount, required this.date});
}

class CreateSchedulingMessageParams {
  final List<ClientEntity> listClients;
  final String message;
  final String date;
  final String createdAt;

  CreateSchedulingMessageParams(
      {required this.listClients,
      required this.message,
      required this.date,
      required this.createdAt});
}

class UpdateSchedulingMessageParams {
  final List<ClientEntity> listClients;
  final String id;
  final String message;
  final String date;
  final String createdAt;

  UpdateSchedulingMessageParams(
      {required this.createdAt,
      required this.id,
      required this.date,
      required this.listClients,
      required this.message});
}

class DeleteSchedulingMessageParams {
  final String id;

  DeleteSchedulingMessageParams({required this.id});
}
