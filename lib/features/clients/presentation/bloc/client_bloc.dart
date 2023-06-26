import 'dart:developer';

import 'package:ariane_app/core/core.dart';
import 'package:flutter/material.dart';
import '../../clients.dart';

class ClientBloc extends Bloc {
  final CreateClientUseCaseImpl createClientUseCaseImpl;
  final ReadClientUseCaseImpl readClientUseCaseImpl;
  final DeleteClientUseCaseImpl deleteClientUseCaseImpl;
  final UpdateClientUseCaseImpl updateClientUseCaseImpl;

  late final List<ClientEntity> listClients;

  ClientBloc(
    this.createClientUseCaseImpl,
    this.readClientUseCaseImpl,
    this.deleteClientUseCaseImpl,
    this.updateClientUseCaseImpl,
  ) {
    listClients = [];
  }

  @override
  mapListenEvent(BlocEvent event) {
    if (event is ClientEventCreateClient) {
      _handleCreateClient(event.context);
    } else if (event is ClientEventReadClient) {
      _handleReadClient();
    } else if (event is ClientEventDeleteClient) {
      _handleDeleteClient(event.context, event.entity);
    } else if (event is ClientEventUpdateClient) {
      _handleUpdateClient(event.context, event.entity);
    }
  }

  _handleCreateClient(
    BuildContext context,
  ) async {
    final ClientEntity? entity = await showCustomDialog(
      context,
      const CreateUpdateClientDialog(client: null),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await createClientUseCaseImpl(CreateClientParams(
      firstName: entity.firstName,
      lastName: entity.lastName,
      number: entity.number,
      birthday: entity.birthday,
    ));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      listClients.add(c);
      showSuccess(context, 'Cliente cadastrado com sucesso');
      dispatchState(BlocStableState(data: listClients));
    });
  }

  _handleReadClient() async {
    dispatchState(BlocLoadingState());
    final request = await readClientUseCaseImpl.call(NoParams());

    request.fold((l) {
      dispatchState(BlocErrorState());
    },
        (r) => {
              listClients.addAll(r),
              if (listClients.isNotEmpty)
                {dispatchState(BlocStableState(data: listClients))}
              else
                {dispatchState(BlocEmptyState())}
            });
  }

  _handleDeleteClient(BuildContext context, ClientEntity entity) async {
    final request =
        await deleteClientUseCaseImpl.call(DeleteClientParams(id: entity.id));

    request.fold((left) => showFailure(context, left.message), (right) {
      listClients.remove(entity);

      if (listClients.isNotEmpty) {
        dispatchState(BlocStableState(data: listClients));
      } else {
        dispatchState(BlocEmptyState());
      }
    });
  }

  _handleUpdateClient(BuildContext context, ClientEntity client) async {
    final ClientEntity? entity = await showCustomDialog(
      context,
      CreateUpdateClientDialog(client: client),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await updateClientUseCaseImpl(UpdateClientParams(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      number: entity.number,
      birthday: entity.birthday,
    ));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      final index = listClients.indexOf(client);
      listClients.remove(client);
      listClients.insert(index, c);
      dispatchState(BlocStableState(data: listClients));
    });
  }
}
