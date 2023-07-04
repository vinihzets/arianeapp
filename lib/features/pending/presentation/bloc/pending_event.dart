import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/features/pending/pending.dart';

class PendingEvent extends BlocEvent {}

class PendingEventOnReady implements PendingEvent {}

class PendingEventLoadMore implements PendingEvent {
  final List<PendingEntity> cache;

  PendingEventLoadMore({
    required this.cache,
  });
}
