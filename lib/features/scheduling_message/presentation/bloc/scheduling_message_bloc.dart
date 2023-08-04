import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/create_scheduling_message_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/delete_scheduling_message_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/scheduling_message_read_clients_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/read_scheduling_messages_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/scheduling_message_search_clients_usecase_imppl.dart';
import 'package:ariane_app/features/scheduling_message/domain/usecases/update_scheduling_message_usecase_impl.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_event.dart';
import 'package:ariane_app/features/scheduling_message/presentation/dialog/create_update_scheduling_message_dialog.dart';
import 'package:flutter/material.dart';

class SchedulingMessageStableData {
  final List<SchedulingMessageEntity> listMessages;
  final bool reachMax;

  SchedulingMessageStableData(
      {required this.listMessages, required this.reachMax});
}

class SchedulingMessageClientsStableData {
  final List<ClientEntity> listClients;
  final bool reachMax;

  SchedulingMessageClientsStableData(
      {required this.listClients, required this.reachMax});
}

class SchedulingMessageBloc extends Bloc {
  CreateSchedulingMessageUseCaseImpl createSchedulingMessageUseCaseImpl;
  UpdateSchedulingMessageUseCaseImpl updateSchedulingMessageUseCaseImpl;
  DeleteSchedulingMessageUseCaseImpl deleteSchedulingMessageUseCaseImpl;
  ReadSchedulingMessagesUseCaseImpl readSchedulingMessagesUseCaseImpl;
  SchedulingMessageReadClientsUseCaseImpl
      schedulingMessageReadClientsUseCaseImpl;
  SchedulingMessageSearchClientsUseCaseImpl
      schedulingMessageSearchClientsUseCaseImpl;

  List<SchedulingMessageEntity> cache = [];
  List<ClientEntity> listClients = [];

  SchedulingMessageBloc(
      this.createSchedulingMessageUseCaseImpl,
      this.deleteSchedulingMessageUseCaseImpl,
      this.readSchedulingMessagesUseCaseImpl,
      this.updateSchedulingMessageUseCaseImpl,
      this.schedulingMessageReadClientsUseCaseImpl,
      this.schedulingMessageSearchClientsUseCaseImpl);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is SchedulingMessageEventCreate) {
      _handleCreate(
        event.context,
      );
    } else if (event is SchedulingMessageEventRead) {
      _handleRead(event.date, event.ammount);
    } else if (event is SchedulingMessageEventDelete) {
      _handleDelete(event.entity);
    } else if (event is SchedulingMessageEventUpdate) {
      _handleUpdate(event.entity, event.context);
    } else if (event is SchedulingMessageEventLoadMore) {
      _handleLoadMore(cache, event.date);
    } else if (event is SchedulingMessageEventGetClients) {
      _handleGetClients(event.ammount);
    } else if (event is SchedulingMessageEventLoadMoreClients) {
      _handleLoadMoreClients(event.ammount);
    } else if (event is SchedulingMessageEventSearchClients) {
      _handleSearchClient(event.query);
    }
  }

  _handleCreate(
    BuildContext context,
  ) async {
    final SchedulingMessageEntity? entity = await showCustomDialog(
        context,
        const CreateUpdateSchedulingMessageDialog(
            schedulingMessageEntity: null));

    if (entity == null) {
      return;
    }

    final result = await createSchedulingMessageUseCaseImpl(
        CreateSchedulingMessageParams(
            listClients: entity.listClients,
            message: entity.message,
            date: entity.date,
            createdAt: entity.createdAt));

    result.fold((l) => showFailure(context, l.message), (r) {
      cache.add(r);

      showSuccess(context, r.message);

      dispatchState(BlocStableState(
          data: SchedulingMessageStableData(
              listMessages: cache, reachMax: true)));
    });
  }

  _handleRead(DateTime date, int ammount) async {
    final result = await readSchedulingMessagesUseCaseImpl(
        ReadSchedulingMessagesParams(ammount: ammount, date: date));

    result.fold((l) {}, (r) {
      cache.addAll(r);

      dispatchState(BlocStableState(
          data: SchedulingMessageStableData(
              listMessages: cache, reachMax: r.length < ammount)));
    });
  }

  _handleUpdate(SchedulingMessageEntity schedulingMessageEntity,
      BuildContext context) async {
    final SchedulingMessageEntity entity = await showCustomDialog(
      context,
      CreateUpdateSchedulingMessageDialog(
        schedulingMessageEntity: schedulingMessageEntity,
      ),
    );

    final result =
        await updateSchedulingMessageUseCaseImpl(UpdateSchedulingMessageParams(
      createdAt: entity.createdAt,
      id: entity.id,
      date: entity.date,
      listClients: entity.listClients,
      message: entity.message,
      sent: entity.sent,
    ));

    result.fold((l) => null, (r) {
      final index = cache.indexOf(entity);

      cache.remove(entity);
      cache.insert(index, r);

      dispatchState(BlocStableState(data: cache));
    });
  }

  _handleDelete(SchedulingMessageEntity entity) async {
    final result = await deleteSchedulingMessageUseCaseImpl(
        DeleteSchedulingMessageParams(id: entity.id));

    result.fold((l) {}, (r) {
      cache.remove(entity);

      dispatchState(BlocStableState(data: cache));
    });
  }

  _handleLoadMore(List<SchedulingMessageEntity> cache, DateTime date) async {
    int fetchAmmount = 10;

    final pendingRequest = await readSchedulingMessagesUseCaseImpl(
        ReadSchedulingMessagesParams(ammount: fetchAmmount, date: date));

    pendingRequest.fold(
      (l) {},
      (r) => dispatchState(
        BlocStableState(
          data: SchedulingMessageStableData(
            listMessages: cache,
            reachMax: r.length < fetchAmmount,
          ),
        ),
      ),
    );
  }

  _handleGetClients(
    int ammount,
  ) async {
    final result = await schedulingMessageReadClientsUseCaseImpl(
        GetClientsParams(ammount, null));

    result.fold((l) => null, (r) {
      listClients.addAll(r);

      dispatchState(BlocStableState(
          data: SchedulingMessageClientsStableData(
              listClients: r, reachMax: false)));
    });
  }

  _handleLoadMoreClients(int ammount) async {
    final result = await schedulingMessageReadClientsUseCaseImpl(
        GetClientsParams(ammount, listClients.last));

    result.fold((l) => null, (r) {
      listClients.addAll(r);

      dispatchState(BlocStableState(
          data: SchedulingMessageClientsStableData(
              listClients: listClients, reachMax: r.length < ammount)));
    });
  }

  _handleSearchClient(String query) async {
    final result = await schedulingMessageSearchClientsUseCaseImpl(
        SearchClientParams(query: query));

    result.fold((l) {
      dispatchState(BlocErrorState());
    }, (r) {
      if (r.isEmpty) {
        dispatchState(BlocEmptyState());
      } else {
        dispatchState(BlocStableState(
            data: SchedulingMessageClientsStableData(
                listClients: r, reachMax: true)));
        listClients.clear();
      }
    });
  }
}
