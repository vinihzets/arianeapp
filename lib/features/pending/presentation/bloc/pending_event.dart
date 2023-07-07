import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/features/pending/pending.dart';
import 'package:flutter/material.dart';

class PendingEvent extends BlocEvent {}

class PendingEventOnReady implements PendingEvent {
  int? dayCounter;
  int? monthCounter;
  int? yearCounter;

  PendingEventOnReady(this.dayCounter, this.monthCounter, this.yearCounter);
}

class PendingEventLoadMore implements PendingEvent {
  final List<PendingEntity> cache;

  PendingEventLoadMore({
    required this.cache,
  });
}

class PendingEventShowSearchDialog implements PendingEvent {
  BuildContext context;
  Widget dialog;

  PendingEventShowSearchDialog(this.context, this.dialog);
}
