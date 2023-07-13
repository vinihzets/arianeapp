import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/features/pending/pending.dart';

class PendingEvent extends BlocEvent {}

class PendingEventOnReady implements PendingEvent {
  final DateTime date;

  PendingEventOnReady(
    this.date,
  );
}

class PendingEventLoadMore implements PendingEvent {
  final List<PendingEntity> cache;
  final DateTime date;

  PendingEventLoadMore({
    required this.cache,
    required this.date,
  });
}
