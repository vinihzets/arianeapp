import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:flutter/material.dart';

class ListViewClientTile extends StatelessWidget {
  final ScrollController? scrollController;
  final ClientStableData data;
  final ClientBloc bloc;
  final ConstRoutes routes;
  const ListViewClientTile(
      {required this.scrollController,
      required this.data,
      required this.bloc,
      required this.routes,
      super.key});

  @override
  Widget build(BuildContext context) {
    final List<ClientEntity> listClients = data.listClients;

    return ListView.separated(
      controller: scrollController,
      itemCount: listClients.length + 1,
      itemBuilder: (context, index) {
        if (index == listClients.length) {
          return Center(
            child: data.reachMax
                ? const Text('Isso é tudo!')
                : const CircularProgressIndicator.adaptive(),
          );
        }

        final client = listClients[index];

        return ListTile(
            leading: IconButton(
                onPressed: () {
                  bloc.dispatchEvent(ClientEventNavigateThenArguments(
                      context, client, routes.perfuration));
                },
                icon: const Icon(
                  Icons.add,
                )),
            title: Text(
              '${client.firstName} ${client.lastName}',
            ),
            trailing: PopupMenuButton<ClientMenuAction>(
              itemBuilder: (_) => [
                const PopupMenuItem<ClientMenuAction>(
                  value: ClientMenuAction.delete,
                  child: Text('Apagar'),
                ),
                const PopupMenuItem<ClientMenuAction>(
                  value: ClientMenuAction.update,
                  child: Text('Atualizar'),
                ),
                const PopupMenuItem<ClientMenuAction>(
                  value: ClientMenuAction.read,
                  child: Text('Visualizar'),
                ),
                const PopupMenuItem<ClientMenuAction>(
                  value: ClientMenuAction.perfurations,
                  child: Text('Perfurações'),
                ),
              ],
              onSelected: (action) {
                switch (action) {
                  case ClientMenuAction.delete:
                    bloc.dispatchEvent(
                        ClientEventDeleteClient(context, client));
                    break;
                  case ClientMenuAction.update:
                    bloc.dispatchEvent(
                        ClientEventUpdateClient(context, client));
                    break;
                  case ClientMenuAction.read:
                    showDialog(
                        context: context,
                        builder: (context) =>
                            ShowCustomClientDetails(entity: client));
                    break;
                  case ClientMenuAction.perfurations:
                    bloc.dispatchEvent(ClientEventNavigateThenArguments(
                        context, client, routes.clientPerfurations));
                    break;
                }
              },
            ));
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
