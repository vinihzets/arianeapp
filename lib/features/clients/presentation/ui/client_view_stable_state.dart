import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:ariane_app/features/clients/presentation/widgets/list_view_client_tile.dart';
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
  late ScrollController scrollController;
  ClientStableData get data => widget.state.data;

  int fetchAmmount = 10;

  @override
  void initState() {
    scrollController = ScrollController();

    scrollController.addListener(onScrollEvent);

    super.initState();
  }

  void onScrollEvent() {
    bool isOnBottomOfScrollList =
        scrollController.offset >= scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange;

    if (isOnBottomOfScrollList && !data.reachMax) {
      widget.bloc.dispatchEvent(ClientEventLoadMore(fetchAmmount));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ClientEntity> listClients = data.listClients;

    return ListViewClientTile(
        scrollController: scrollController,
        listClients: listClients,
        bloc: widget.bloc);
  }
}
