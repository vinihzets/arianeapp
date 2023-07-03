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

    bloc.dispatchEvent(PerfurationReadTypePerfuration());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Perfuração'),
        centerTitle: true,
      ),
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
    );
  }
}

/*





 */
