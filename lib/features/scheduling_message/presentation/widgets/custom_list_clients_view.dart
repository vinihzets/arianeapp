import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_event.dart';
import 'package:ariane_app/features/scheduling_message/presentation/widgets/custom_list_clients_view_empty_state.dart';
import 'package:ariane_app/features/scheduling_message/presentation/widgets/custom_list_clients_view_stable_state.dart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/components/text_field_delayed.dart';
import '../../../clients/domain/entities/client_entity.dart';

class CustomListClientsView extends StatefulWidget {
  const CustomListClientsView({super.key});

  @override
  State<CustomListClientsView> createState() => _CustomListClientsViewState();
}

class _CustomListClientsViewState extends State<CustomListClientsView> {
  late SchedulingMessageBloc bloc;
  int fetchAmmount = 10;

  @override
  void initState() {
    bloc = GetIt.I.get();

    bloc.dispatchEvent(SchedulingMessageEventGetClients(
      ammount: fetchAmmount,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ClientEntity> selecteds =
        ModalRoute.of(context)?.settings.arguments as List<ClientEntity>;

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldDelayed(
              onClear: () {
                bloc.dispatchEvent(
                    SchedulingMessageEventGetClients(ammount: fetchAmmount));
              },
              onChanged: (v) {
                bloc.dispatchEvent(
                    SchedulingMessageEventSearchClients(query: v));
              },
            ),
          ),
          Expanded(
            child: BlocScreenBuilder(
                stream: bloc.state,
                onStable: (onStable) => CustomListClientsViewStableState(
                      state: onStable,
                      bloc: bloc,
                      listSelecteds: selecteds,
                    ),
                onError: (onError) => const SizedBox.shrink(),
                onLoading: (onLoading) => const SizedBox.shrink(),
                onEmpty: (onEmpty) => const CustomListClientViewEmptyState()),
          ),
        ],
      ),
    );
  }
}
