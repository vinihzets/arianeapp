import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/components/show_confirmation_dialog.dart';
import 'package:ariane_app/features/clients/domain/usecases/search_client_usecase_impl.dart';
import 'package:flutter/material.dart';
import '../../clients.dart';

class ClientStableData {
  final List<ClientEntity> listClients;
  final bool reachMax;

  ClientStableData({required this.listClients, required this.reachMax});
}

class ClientBloc extends Bloc {
  final CreateClientUseCaseImpl createClientUseCaseImpl;
  final ReadClientUseCaseImpl readClientUseCaseImpl;
  final DeleteClientUseCaseImpl deleteClientUseCaseImpl;
  final UpdateClientUseCaseImpl updateClientUseCaseImpl;
  final SearchClientUseCaseImpl searchClientUseCaseImpl;
  final ConstRoutes routes;
  late final List<ClientEntity> listClients;

  ClientBloc(
    this.createClientUseCaseImpl,
    this.readClientUseCaseImpl,
    this.deleteClientUseCaseImpl,
    this.updateClientUseCaseImpl,
    this.searchClientUseCaseImpl,
    this.routes,
  ) {
    listClients = [];
  }

  @override
  mapListenEvent(BlocEvent event) {
    if (event is ClientEventCreateClient) {
      _handleCreateClient(event.context);
    } else if (event is ClientEventReadClient) {
      _handleReadClient(event.ammount);
    } else if (event is ClientEventDeleteClient) {
      _handleDeleteClient(event.context, event.entity);
    } else if (event is ClientEventUpdateClient) {
      _handleUpdateClient(event.context, event.entity);
    } else if (event is ClientEventNavigateToPerfuration) {
      _handleClientNavigateToPerfuration(event.context, event.entity);
    } else if (event is ClientEventLoadMore) {
      _handleGetMore(event.ammount);
    } else if (event is ClientEventSearch) {
      _handleSearchClient(event.query);
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
      dispatchState(BlocStableState(
          data: ClientStableData(listClients: listClients, reachMax: false)));
    });
  }

  _handleReadClient(int ammount) async {
    dispatchState(BlocLoadingState());
    final request =
        await readClientUseCaseImpl.call(GetClientsParams(ammount, null));

    request.fold((l) {
      dispatchState(BlocErrorState());
    },
        (r) => {
              listClients.addAll(r),
              if (listClients.isNotEmpty)
                {
                  dispatchState(BlocStableState(
                      data: ClientStableData(
                          listClients: listClients,
                          reachMax: r.length < ammount)))
                }
              else
                {dispatchState(BlocEmptyState())}
            });
  }

  _handleDeleteClient(BuildContext context, ClientEntity entity) async {
    final confirmation = await showCustomDialog(
        context,
        const ShowConfirmationDialog(
          message: 'Você realmente deseja apagar esse cliente?',
        ));

    if (confirmation == null) {
      return;
    }

    final request =
        await deleteClientUseCaseImpl.call(DeleteClientParams(id: entity.id));

    // ignore: use_build_context_synchronously

    request.fold((left) => showFailure(context, left.message), (right) {
      listClients.remove(entity);

      if (listClients.isNotEmpty) {
        dispatchState(BlocStableState(
            data: ClientStableData(listClients: listClients, reachMax: false)));
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
      dispatchState(BlocStableState(
          data: ClientStableData(listClients: listClients, reachMax: false)));
    });
  }

  _handleClientNavigateToPerfuration(
      BuildContext context, ClientEntity entity) {
    navigateThenUntil(context, routes.perfuration, entity);
  }

  _handleGetMore(int ammount) async {
    final request = await readClientUseCaseImpl(
        GetClientsParams(ammount, listClients.last));

    request.fold((l) {}, (r) {
      listClients.addAll(r);

      dispatchState(BlocStableState(
          data: ClientStableData(
              listClients: listClients, reachMax: r.length < ammount)));
    });
  }

  _handleSearchClient(String query) async {
    final result =
        await searchClientUseCaseImpl(SearchClientParams(query: query));

    result.fold((l) {
      dispatchState(BlocErrorState());
    }, (r) {
      if (r.isEmpty) {
        dispatchState(BlocEmptyState());
      } else {
        dispatchState(BlocStableState(
            data: ClientStableData(listClients: r, reachMax: true)));
      }
    });
  }
}
