import 'package:ariane_app/core/core.dart';

import '../../domain/entities/scheduling_message_entity.dart';
import '../../domain/usecases/create_scheduling_message_usecase_impl.dart';

class SchedulingMessageStableData {
  final List<SchedulingMessageEntity> schedulingMessages;
  final bool reachMax;
  final DateTime date;

  SchedulingMessageStableData({
    required this.schedulingMessages,
    required this.reachMax,
    required this.date,
  });
}

class SchedulingMessageBloc extends Bloc {
  CreateSchedulingMessageUseCaseImpl createSchedulingMessageUseCaseImpl;
  ConstRoutes routes;

  SchedulingMessageBloc(this.createSchedulingMessageUseCaseImpl, this.routes);

  final fetchAmmount = 10;

  @override
  mapListenEvent(BlocEvent event) {
    if (event is SchedulingMessageEventOnReady) {
      _handleReadyEvent(event.date);
    } else if (event is SchedulingMessageEventLoadMore) {
      _handleLoadMore(event.cache, event.date);
    }
  }

  _handleReadyEvent(DateTime date) async {
    dispatchState(BlocLoadingState());

    final schedulingMessageRequest = await createSchedulingMessageUseCaseImpl(
      CreateSchedulingMessagesParams(
        date: date,
        startAfter: null,
        ammount: fetchAmmount,
      ),
    );

    schedulingMessageRequest.fold(
      (l) {},
      (r) => dispatchState(
        BlocStableState(
          data: SchedulingMessageStableData(
            date: date,
            SchedulingMessages: r,
            reachMax: r.length < fetchAmmount,
          ),
        ),
      ),
    );
  }

  _handleLoadMore(List<SchedulingMessageEntity> cache, DateTime date) async {
    final schedulingMessageRequest = await createSchedulingMessageUseCaseImpl(
      CreateSchedulingMessageParams(
        date: date,
        startAfter: cache.last,
        ammount: fetchAmmount,
      ),
    );

    schedulingMessageRequest.fold(
      (l) {},
      (r) => dispatchState(
        BlocStableState(
          data: SchedulingMessageStableData(
            date: date,
            SchedulingMessages: r,
            reachMax: r.length < fetchAmmount,
          ),
        ),
      ),
    );
  }
}
