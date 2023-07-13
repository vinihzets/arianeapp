import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/scheduling_message/scheduling_message.dart';

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
    bloc.dispatchEvent(PendingEventOnReady(DateTime.now()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
        onEmpty: (onEmpty) => const SizedBox.shrink(),
        onError: (onError) => const SizedBox.shrink(),
        onLoading: (onLoading) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        onStable: (onStable) => SchedulingMessageViewStableData(
          bloc: bloc,
          state: onStable,
        ),
        stream: bloc.state,
      ),
    );
  }
}
