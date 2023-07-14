import 'package:ariane_app/core/components/bloc_screen_builder.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_event.dart';
import 'package:ariane_app/features/scheduling_message/presentation/ui/scheduling_message_view_stable_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SchedulingMessageView extends StatefulWidget {
  const SchedulingMessageView({super.key});

  @override
  State<SchedulingMessageView> createState() => _SchedulingMessageViewState();
}

class _SchedulingMessageViewState extends State<SchedulingMessageView> {
  late SchedulingMessageBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
          stream: bloc.state,
          onStable: (s) =>
              SchedulingMessageViewStableState(bloc: bloc, state: s),
          onError: (s) => const SizedBox.shrink(),
          onLoading: (s) => const SizedBox.shrink(),
          onEmpty: (s) => const SizedBox.shrink()),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Novo agendamento de mensagem'),
          onPressed: () => bloc.dispatchEvent(
              SchedulingMessageEventCreate(context: context, bloc: bloc))),
    );
  }
}
