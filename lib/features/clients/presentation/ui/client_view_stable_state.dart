import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/clients/presentation/widgets/list_view_client_tile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../clients.dart';

enum ClientMenuAction {
  delete,
  update,
  read,
  perfurations,
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
  late ConstRoutes routes;
  ClientStableData get data => widget.state.data;

  int fetchAmmount = 10;

  @override
  void initState() {
    scrollController = ScrollController();
    routes = GetIt.I.get();

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
    return ListViewClientTile(
      scrollController: scrollController,
      data: data,
      bloc: widget.bloc,
      routes: routes,
    );
  }
}
