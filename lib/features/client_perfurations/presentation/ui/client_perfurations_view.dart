import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/client_perfurations/presentation/bloc/client_perfurations_bloc.dart';
import 'package:ariane_app/features/client_perfurations/presentation/bloc/client_perfurations_event.dart';
import 'package:ariane_app/features/client_perfurations/presentation/ui/client_perfurations_view_empty_state.dart';
import 'package:ariane_app/features/client_perfurations/presentation/ui/client_perfurations_view_error_state.dart';
import 'package:ariane_app/features/client_perfurations/presentation/ui/client_perfurations_view_loading_state.dart';
import 'package:ariane_app/features/client_perfurations/presentation/ui/client_perfurations_view_stable_state.dart';
import 'package:ariane_app/features/clients/clients.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ClientPerfurationsView extends StatefulWidget {
  const ClientPerfurationsView({super.key});

  @override
  State<ClientPerfurationsView> createState() => _ClientPerfurationsViewState();
}

class _ClientPerfurationsViewState extends State<ClientPerfurationsView> {
  late ClientPerfurationsBloc bloc;
  @override
  void initState() {
    bloc = GetIt.I.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final client = ModalRoute.of(context)?.settings.arguments as ClientEntity;
    bloc.dispatchEvent(ClientPerfurationsEventReadPerfurations(client));

    return Scaffold(
      body: BlocScreenBuilder(
          stream: bloc.state,
          onStable: (state) => ClientPerfurationsViewStableState(
                state: state,
                onDelete: (String perfurationID) {
                  bloc.dispatchEvent(ClientPerfurationsEventDeletePerfuration(
                      perfurationID, context));
                },
              ),
          onError: (state) => ClientPerfurationsViewErrorState(
                state: state,
                bloc: bloc,
              ),
          onLoading: (state) => const ClientPerfurationsViewLoadingState(),
          onEmpty: (state) => const ClientPerfurationsViewEmptyState()),
    );
  }
}
