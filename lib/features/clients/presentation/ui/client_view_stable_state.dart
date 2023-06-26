import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';
import '../../clients.dart';

enum ClientMenuAction {
  delete,
  update,
}

class ClientViewStableState extends StatefulWidget {
  final BlocState state;
  final ClientBloc bloc;
  const ClientViewStableState(
      {required this.state, required this.bloc, super.key});

  @override
  State<ClientViewStableState> createState() => _ClientViewStableStateState();
}

class _ClientViewStableStateState extends State<ClientViewStableState> {
  @override
  Widget build(BuildContext context) {
    List<ClientEntity> listClients = widget.state.data;

    return ListView.builder(
      itemCount: listClients.length,
      itemBuilder: (context, index) {
        final client = listClients[index];
        return ListTile(
            leading: Text(client.firstName),
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
              ],
              onSelected: (action) {
                switch (action) {
                  case ClientMenuAction.delete:
                    widget.bloc.dispatchEvent(
                        ClientEventDeleteClient(context, client));
                    break;
                  case ClientMenuAction.update:
                    widget.bloc.dispatchEvent(
                        ClientEventUpdateClient(context, client));
                    break;
                }
              },
            ));
      },
    );
  }
}
