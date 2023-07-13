import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/pending/domain/domain.dart';
import 'pending_event.dart';

class PendingStableData {
  final List<PendingEntity> pendings;
  final bool reachMax;
  final DateTime date;

  PendingStableData({
    required this.pendings,
    required this.reachMax,
    required this.date,
  });
}

class PendingBloc extends Bloc {
  GetPendingUseCaseImpl getPendingUseCaseImpl;
  ConstRoutes routes;

  PendingBloc(this.getPendingUseCaseImpl, this.routes);

  final fetchAmmount = 10;

  @override
  mapListenEvent(BlocEvent event) {
    if (event is PendingEventOnReady) {
      _handleReadyEvent(event.date);
    } else if (event is PendingEventLoadMore) {
      _handleLoadMore(event.cache, event.date);
    }
  }

  _handleReadyEvent(DateTime date) async {
    dispatchState(BlocLoadingState());

    final pendingRequest = await getPendingUseCaseImpl(
      GetPendingsParams(
        date: date,
        startAfter: null,
        ammount: fetchAmmount,
      ),
    );

    pendingRequest.fold(
      (l) {},
      (r) => dispatchState(
        BlocStableState(
          data: PendingStableData(
            date: date,
            pendings: r,
            reachMax: r.length < fetchAmmount,
          ),
        ),
      ),
    );
  }

  _handleLoadMore(List<PendingEntity> cache, DateTime date) async {
    final pendingRequest = await getPendingUseCaseImpl(
      GetPendingsParams(
        date: date,
        startAfter: cache.last,
        ammount: fetchAmmount,
      ),
    );

    pendingRequest.fold(
      (l) {},
      (r) => dispatchState(
        BlocStableState(
          data: PendingStableData(
            date: date,
            pendings: r,
            reachMax: r.length < fetchAmmount,
          ),
        ),
      ),
    );
  }
}
