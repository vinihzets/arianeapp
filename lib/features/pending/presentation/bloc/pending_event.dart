import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/features/pending/pending.dart';
import 'package:flutter/material.dart';

class PendingEvent extends BlocEvent {}

class PendingEventOnReady implements PendingEvent {
  final DateTime date;

  PendingEventOnReady({required this.date});
}

class PendingEventLoadMore implements PendingEvent {
  final List<PendingEntity> cache;
  final DateTime date;

  PendingEventLoadMore({required this.cache, required this.date});
}

class PendingEventShowSearchDialog implements PendingEvent {
  BuildContext context;
  Widget dialog;

  PendingEventShowSearchDialog(this.context, this.dialog);
}

class PendingEventSendMessage implements PendingEvent {
  final PendingEntity entity;
  final DateTime date;

  PendingEventSendMessage(this.entity, this.date);
}
