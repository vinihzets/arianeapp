import 'package:ariane_app/features/clients/domain/entities/client_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class PerfurationEvent extends BlocEvent {}

class PerfurationEventCreatePerfuration implements PerfurationEvent {
  BuildContext context;
  ClientEntity client;
  TypePerfurationEntity typePerfuration;

  PerfurationEventCreatePerfuration(
    this.context,
    this.client,
    this.typePerfuration,
  );
}

class PerfurationEventReadPerfuration implements PerfurationEvent {}

class PerfurationEventDeletePerfuration implements PerfurationEvent {
  BuildContext context;
  PerfurationEntity entity;

  PerfurationEventDeletePerfuration(this.context, this.entity);
}

class PerfurationReadTypePerfuration implements PerfurationEvent {}
