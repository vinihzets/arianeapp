import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/pending/pending.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PendingView extends StatefulWidget {
  const PendingView({super.key});

  @override
  State<PendingView> createState() => _PendingViewState();
}

class _PendingViewState extends State<PendingView> {
  late PendingBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.dispatchEvent(PendingEventOnReady(date: DateTime.now()));

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
        onStable: (onStable) => PendingViewStableData(
          bloc: bloc,
          state: onStable,
        ),
        stream: bloc.state,
      ),
    );
  }
}
