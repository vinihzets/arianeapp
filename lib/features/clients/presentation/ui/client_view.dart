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

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.dispatchEvent(ClientEventReadClient());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
        stream: bloc.state,
        onEmpty: (state) => ClientViewEmptyState(state: state),
        onError: (state) => ClientViewErrorState(
          state: state,
        ),
        onLoading: (state) => ClientViewLoadingState(state: state),
        onStable: (state) => ClientViewStableState(state: state, bloc: bloc),
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
