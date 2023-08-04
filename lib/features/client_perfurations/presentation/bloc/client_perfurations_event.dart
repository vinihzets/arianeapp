import 'package:ariane_app/features/clients/clients.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class ClientPerfurationsEvent extends BlocEvent {}

class ClientPerfurationsEventReadPerfurations
    implements ClientPerfurationsEvent {
  final ClientEntity entity;

  ClientPerfurationsEventReadPerfurations(this.entity);
}

class ClientPerfurationsEventDeletePerfuration
    implements ClientPerfurationsEvent {
  final String id;
  final BuildContext context;

  ClientPerfurationsEventDeletePerfuration(this.id, this.context);
}
