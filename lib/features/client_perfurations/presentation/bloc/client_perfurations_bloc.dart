import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/client_perfurations/domain/usecases/delete_client_perfuration_usecase_impl.dart';
import 'package:ariane_app/features/client_perfurations/domain/usecases/read_client_perfurations_usecase_impl.dart';
import 'package:ariane_app/features/client_perfurations/presentation/bloc/client_perfurations_event.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:flutter/material.dart';

class ClientPerfurationsStableData {
  final List<PerfurationEntity> perfurations;
  final ClientEntity client;

  ClientPerfurationsStableData(
      {required this.client, required this.perfurations});
}

class ClientPerfurationsBloc extends Bloc {
  ReadClientPerfurationsUseCaseImpl readClientPerfurationsUseCaseImpl;
  DeleteClientPerfurationUseCaseImpl deleteClientPerfurationUseCaseImpl;

  ClientPerfurationsBloc(this.readClientPerfurationsUseCaseImpl,
      this.deleteClientPerfurationUseCaseImpl);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is ClientPerfurationsEventReadPerfurations) {
      _handleClientPerfurationsReadPerfurations(event.entity);
    } else if (event is ClientPerfurationsEventDeletePerfuration) {
      _handleClientPerfurationDeletePerfuration(event.id, event.context);
    }
  }

  _handleClientPerfurationsReadPerfurations(ClientEntity entity) async {
    dispatchState(BlocLoadingState());
    final result = await readClientPerfurationsUseCaseImpl
        .call(ReadClientPerfurationsParams(entity));

    result.fold((l) {
      dispatchState(BlocErrorState());
    }, (r) {
      if (r.isEmpty) {
        dispatchState(BlocEmptyState());
      } else {
        dispatchState(BlocStableState(
            data:
                ClientPerfurationsStableData(client: entity, perfurations: r)));
      }
    });
  }

  _handleClientPerfurationDeletePerfuration(
      String id, BuildContext context) async {
    final result = await deleteClientPerfurationUseCaseImpl
        .call(DeleteClientPerfurationParams(id));
    result.fold((l) {
      showSnack(
          context, 'Não foi possivel remover essa perfuração', Colors.red);
    }, (r) {
      showSnack(context, 'Perfuração do usuario removida.', Colors.green);
    });
  }
}
