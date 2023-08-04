import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/client_perfurations/presentation/bloc/client_perfurations_bloc.dart';
import 'package:flutter/material.dart';

class ClientPerfurationsViewErrorState extends StatefulWidget {
  final BlocState state;
  final ClientPerfurationsBloc bloc;
  const ClientPerfurationsViewErrorState({
    super.key,
    required this.state,
    required this.bloc,
  });

  @override
  State<ClientPerfurationsViewErrorState> createState() =>
      _ClientPerfurationsViewErrorStateState();
}

class _ClientPerfurationsViewErrorStateState
    extends State<ClientPerfurationsViewErrorState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Tente novamente mais tarde.')),
    );
  }
}
