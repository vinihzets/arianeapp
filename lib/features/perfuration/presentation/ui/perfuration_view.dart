import 'dart:developer';

import 'package:ariane_app/features/periods/periods.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/core.dart';
import '../../perfurations.dart';

class PerfurationView extends StatefulWidget {
  const PerfurationView({super.key});

  @override
  State<PerfurationView> createState() => _PerfurationViewState();
}

class _PerfurationViewState extends State<PerfurationView> {
  late PerfurationsBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();

    bloc.dispatchEvent(PerfurationEventReadPerfuration());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
        stream: bloc.state,
        onEmpty: (state) => PerfurationViewEmptyState(state: state),
        onError: (state) => PerfurationViewErrorState(
          state: state,
        ),
        onLoading: (state) => PerfurationViewLoadingState(state: state),
        onStable: (state) =>
            PerfurationViewStableState(state: state, bloc: bloc),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            bloc.dispatchEvent(PerfurationEventCreatePerfuration(context)),
        label: const Text('Nova Perfuração'),
        icon: const Icon(Icons.person_add_alt_outlined),
      ),
    );
  }
}

/*





 */
