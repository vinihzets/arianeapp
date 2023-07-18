import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:flutter/material.dart';

class SchedulingMessageEvent extends BlocEvent {}

class SchedulingMessageEventCreate implements SchedulingMessageEvent {
  final BuildContext context;
  final SchedulingMessageBloc bloc;

  SchedulingMessageEventCreate({
    required this.context,
    required this.bloc,
  });
}

class SchedulingMessageEventRead implements SchedulingMessageEvent {
  final DateTime date;
  final int ammount;

  SchedulingMessageEventRead({required this.date, required this.ammount});
}

class SchedulingMessageEventUpdate implements SchedulingMessageEvent {
  final SchedulingMessageEntity entity;
  final BuildContext context;

  SchedulingMessageEventUpdate({required this.entity, required this.context});
}

class SchedulingMessageEventDelete implements SchedulingMessageEvent {
  final SchedulingMessageEntity entity;

  SchedulingMessageEventDelete({required this.entity});
}

class SchedulingMessageEventLoadMore implements SchedulingMessageEvent {
  final DateTime date;

  SchedulingMessageEventLoadMore({required this.date});
}

class SchedulingMessageEventGetClients implements SchedulingMessageEvent {
  final int ammount;

  SchedulingMessageEventGetClients({required this.ammount});
}

class SchedulingMessageEventLoadMoreClients implements SchedulingMessageEvent {
  final int ammount;

  SchedulingMessageEventLoadMoreClients({required this.ammount});
}

class SchedulingMessageEventSearchClients implements SchedulingMessageEvent {
  final String query;

  SchedulingMessageEventSearchClients({required this.query});
}
