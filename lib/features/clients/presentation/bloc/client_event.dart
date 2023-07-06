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

class ClientEventReadClient implements ClientEvent {
  int ammount;

  ClientEventReadClient(this.ammount);
}

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

class ClientEventNavigateToPerfuration implements ClientEvent {
  BuildContext context;
  ClientEntity entity;

  ClientEventNavigateToPerfuration(this.context, this.entity);
}

class ClientEventLoadMore implements ClientEvent {
  int ammount;

  ClientEventLoadMore(this.ammount);
}

class ClientEventSearch implements ClientEvent {
  String query;

  ClientEventSearch(this.query);
}
