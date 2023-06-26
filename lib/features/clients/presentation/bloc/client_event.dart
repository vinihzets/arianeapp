import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../clients.dart';

class ClientEvent extends BlocEvent {}

class ClientEventCreateClient implements ClientEvent {
  BuildContext context;

  ClientEventCreateClient(
    this.context,
  );
}

class ClientEventReadClient implements ClientEvent {}

class ClientEventDeleteClient implements ClientEvent {
  BuildContext context;
  ClientEntity entity;

  ClientEventDeleteClient(this.context, this.entity);
}

class ClientEventUpdateClient implements ClientEvent {
  BuildContext context;
  ClientEntity entity;

  ClientEventUpdateClient(this.context, this.entity);
}
