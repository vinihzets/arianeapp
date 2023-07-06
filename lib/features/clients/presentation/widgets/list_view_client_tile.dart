import 'package:ariane_app/features/clients/clients.dart';
import 'package:flutter/material.dart';

class ListViewClientTile extends StatelessWidget {
  final ScrollController? scrollController;
  final List<ClientEntity> listClients;
  final ClientBloc bloc;
  const ListViewClientTile(
      {required this.scrollController,
      required this.listClients,
      required this.bloc,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: listClients.length,
      itemBuilder: (context, index) {
        final client = listClients[index];

        return ListTile(
            leading: IconButton(
                onPressed: () {
                  bloc.dispatchEvent(
                      ClientEventNavigateToPerfuration(context, client));
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
                }
              },
            ));
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
