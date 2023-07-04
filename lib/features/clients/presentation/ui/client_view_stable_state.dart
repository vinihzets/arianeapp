import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';
import '../../clients.dart';

enum ClientMenuAction {
  delete,
  update,
  read,
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

    return ListView.separated(
      itemCount: listClients.length,
      itemBuilder: (context, index) {
        final client = listClients[index];
        return ListTile(
          leading: IconButton(
              onPressed: () {
                widget.bloc.dispatchEvent(
                    ClientEventNavigateToPerfuration(context, client));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.deepPurple,
              )),
          title: Text(
            '${client.firstName} ${client.lastName}',
            style: const TextStyle(fontSize: 18),
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
                  widget.bloc
                      .dispatchEvent(ClientEventDeleteClient(context, client));
                  break;
                case ClientMenuAction.update:
                  widget.bloc
                      .dispatchEvent(ClientEventUpdateClient(context, client));
                  break;
                case ClientMenuAction.read:
                  showDialog(
                      context: context,
                      builder: (context) =>
                          ShowCustomClientDetails(entity: client));
              }
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
