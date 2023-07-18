import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_event.dart';
import 'package:flutter/material.dart';

import '../../../clients/domain/entities/client_entity.dart';

class CustomListClientsViewStableState extends StatefulWidget {
  final BlocState state;
  final SchedulingMessageBloc bloc;
  final List<ClientEntity> listSelecteds;
  const CustomListClientsViewStableState(
      {required this.state,
      required this.bloc,
      required this.listSelecteds,
      super.key});

  @override
  State<CustomListClientsViewStableState> createState() =>
      _CustomListClientsViewStableStateState();
}

class _CustomListClientsViewStableStateState
    extends State<CustomListClientsViewStableState> {
  late ScrollController controller;
  late List<ClientEntity> selecteds;
  final int fetchAmmount = 10;
  late Map<ClientEntity, bool> selectedMap;

  @override
  void initState() {
    selecteds = widget.listSelecteds;
    selectedMap = {};

    for (var element in selecteds) {
      selectedMap[element] = true;
    }

    controller = ScrollController();
    controller.addListener(onScrollEvent);

    super.initState();
  }

  void onScrollEvent() {
    bool isOnBottomOfScrollList =
        controller.offset >= controller.position.maxScrollExtent &&
            !controller.position.outOfRange;

    if (isOnBottomOfScrollList && !widget.state.data.reachMax) {
      widget.bloc.dispatchEvent(SchedulingMessageEventLoadMoreClients(
        ammount: fetchAmmount,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ClientEntity> listClients = widget.state.data.listClients;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(selecteds);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text('Clientes'),
          centerTitle: true,
        ),
        body: ListView.separated(
          controller: controller,
          itemCount: listClients.length + 1,
          itemBuilder: (context, index) {
            if (index == listClients.length) {
              return Center(
                child: widget.state.data.reachMax
                    ? const Text('Isso é tudo!')
                    : const CircularProgressIndicator.adaptive(),
              );
            }

            final client = listClients[index];

            return CheckboxListTile(
              title: Text(client.firstName),
              value: selectedMap[client] ?? false,
              onChanged: (bool? selecionado) {
                setState(() {
                  selectedMap[client] = selecionado ?? false;

                  if (selecionado == true) {
                    selecteds.add(client);
                  } else {
                    selecteds.remove(client);
                  }
                });
              },
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ));
  }
}
