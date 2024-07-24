import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/pending/domain/domain.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:flutter/material.dart';
import 'pending_event.dart';

class PendingStableData {
  final List<PendingEntity> pendings;
  final bool reachMax;
  final DateTime date;
  final List<SchedulingMessageEntity> messages;

  PendingStableData({
    required this.pendings,
    required this.reachMax,
    required this.date,
    required this.messages,
  });
}

class PendingBloc extends Bloc {
  GetPendingUseCaseImpl getPendingUseCaseImpl;
  GetMessagesUseCaseImpl getMessagesUseCaseImpl;

  ConstRoutes routes;

  PendingBloc(
    this.getPendingUseCaseImpl,
    this.getMessagesUseCaseImpl,
    this.routes,
  );

  final fetchAmmount = 10;

  @override
  mapListenEvent(BlocEvent event) {
    if (event is PendingEventOnReady) {
      _handleReadyEvent(event.date);
    } else if (event is PendingEventLoadMore) {
      _handleLoadMore(event.cache, event.messages, event.date);
    } else if (event is PendingEventSendMessage) {
      _handleSendMessage(event.context, event.entity, event.date);
    } else if (event is PendingEventSendMessageToList) {
      _handleSendMessageToList(event.context, event.entity, event.date);
    }
  }

  _handleSendMessage(
    BuildContext context,
    PendingEntity entity,
    DateTime date,
  ) async {
    final result = await WhatsApp.sendMessage(
      entity.clientNumber,
      entity.message,
    );

    if (result) {
      DatabaseService().pendings.doc(entity.id).update({'sent': true});
      _handleReadyEvent(date);
    }
  }

  _handleSendMessageToList(
    BuildContext context,
    SchedulingMessageEntity entity,
    DateTime date,
  ) async {
    final list = entity.listClients;
    ClientEntity? selected;

    if (list.length == 1) {
      selected = list.first;
    } else {
      selected = await showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Column(
              children: list
                  .map((e) => ListTile(
                        title: Text(e.firstName),
                        subtitle: Text(e.lastName),
                        onTap: () => Navigator.of(context).pop(e),
                      ))
                  .toList()),
        ),
      ) as ClientEntity?;
    }

    if (selected == null) {
      return;
    }

    final result = await WhatsApp.sendMessage(
      selected.number,
      entity.message,
    );

    if (result) {
      DatabaseService().schedulingMessages.doc(entity.id).update(
        {'sent': true},
      );
      _handleReadyEvent(date);
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

    final pendings = pendingRequest.fold((l) => <PendingEntity>[], (r) => r);

    final messagesRequest = await getMessagesUseCaseImpl(
      GetMessagesParams(date: date),
    );

    final messages = messagesRequest.fold(
      (l) => <SchedulingMessageEntity>[],
      (r) => r,
    );

    dispatchState(
      BlocStableState(
        data: PendingStableData(
          date: date,
          pendings: pendings,
          reachMax: pendings.length < fetchAmmount,
          messages: messages,
        ),
      ),
    );
  }

  _handleLoadMore(List<PendingEntity> cache,
      List<SchedulingMessageEntity> messages, DateTime date) async {
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
            messages: messages,
          ),
        ),
      ),
    );
  }
}
