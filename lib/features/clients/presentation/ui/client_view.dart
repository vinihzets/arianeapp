import 'package:ariane_app/core/components/text_field_delayed.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/core.dart';
import '../../clients.dart';

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  late ClientBloc bloc;
  late ClientDataSources dataSources;
  final fetchAmmount = 10;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.dispatchEvent(ClientEventReadClient(fetchAmmount));
    dataSources = GetIt.I.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldDelayed(
              onClear: () {
                bloc.dispatchEvent(ClientEventReadClient(fetchAmmount));
              },
              onChanged: (v) {
                bloc.dispatchEvent(ClientEventSearch(v));
              },
            ),
          ),
          Expanded(
            child: BlocScreenBuilder(
              stream: bloc.state,
              onEmpty: (state) => ClientViewEmptyState(state: state),
              onError: (state) => ClientViewErrorState(
                state: state,
              ),
              onLoading: (state) => ClientViewLoadingState(state: state),
              onStable: (state) =>
                  ClientViewStableState(state: state, bloc: bloc),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => bloc.dispatchEvent(ClientEventCreateClient(context)),
        label: const Text('Cadastrar Novo Cliente'),
        icon: const Icon(Icons.person_add_alt_outlined),
      ),
    );
  }
}

/*





 */
