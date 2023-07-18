import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/failure/failure.dart';
import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:ariane_app/features/scheduling_message/data/datasources/scheduling_message_datasources.dart';

import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/scheduling_message_repository.dart';

class SchedulingMessageRepositoryImpl implements SchedulingMessageRepository {
  SchedulingMessageDataSources dataSources;

  SchedulingMessageRepositoryImpl(this.dataSources);

  @override
  Future<Either<Failure, SchedulingMessageEntity>> createSchedulingMessage(
      CreateSchedulingMessageParams params) async {
    try {
      return Right(await dataSources.createSchedulingMessage(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSchedulingMessage(
      DeleteSchedulingMessageParams params) async {
    try {
      return Right(await dataSources.deleteSchedulingMessage(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SchedulingMessageEntity>>>
      readSchedulingsMessages() async {
    try {
      return Right(await dataSources.readSchedulingsMessages());
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SchedulingMessageEntity>> updateSchedulingMessage(
      UpdateSchedulingMessageParams params) async {
    try {
      return Right(await dataSources.updateSchedulingMessage(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ClientEntity>>> getClients(
      GetClientsParams params) async {
    try {
      return Right(await dataSources.getClients(params));
    } on Exception catch (e) {
      return Left(RemoteFailure(message: e.toString()));
    }
  }
}
