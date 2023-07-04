import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/pending/domain/domain.dart';

import 'pending_event.dart';

class PendingStableData {
  final List<PendingEntity> pendings;
  final bool reachMax;

  PendingStableData({
    required this.pendings,
    required this.reachMax,
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
      _handleReadyEvent();
    } else if (event is PendingEventLoadMore) {
      _handleLoadMore(event.cache);
    }
  }

  _handleReadyEvent() async {
    dispatchState(BlocLoadingState());

    final pendingRequest = await getPendingUseCaseImpl(
      GetPendingsParams(
        date: DateTime.now(),
        startAfter: null,
        ammount: fetchAmmount,
      ),
    );

    pendingRequest.fold(
      (l) {},
      (r) => dispatchState(
        BlocStableState(
          data: PendingStableData(
            pendings: r,
            reachMax: r.length < fetchAmmount,
          ),
        ),
      ),
    );
  }

  _handleLoadMore(List<PendingEntity> cache) async {
    final pendingRequest = await getPendingUseCaseImpl(
      GetPendingsParams(
        date: DateTime.now(),
        startAfter: cache.last,
        ammount: fetchAmmount,
      ),
    );

    pendingRequest.fold(
      (l) {},
      (r) => dispatchState(
        BlocStableState(
          data: PendingStableData(
            pendings: r,
            reachMax: r.length < fetchAmmount,
          ),
        ),
      ),
    );
  }
}
