import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/core.dart';
import '../../../../core/drawer/presentation/ui/custom_drawer.dart';
import '../../periods.dart';

class PeriodView extends StatefulWidget {
  const PeriodView({super.key});

  @override
  State<PeriodView> createState() => _PeriodViewState();
}

class _PeriodViewState extends State<PeriodView> {
  late PeriodsBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.dispatchEvent(PeriodEventReadPeriod());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: BlocScreenBuilder(
        stream: bloc.state,
        onEmpty: (state) => PeriodViewEmptyState(state: state),
        onError: (state) => PeriodViewErrorState(
          state: state,
        ),
        onLoading: (state) => PeriodViewLoadingState(state: state),
        onStable: (state) => PeriodsViewStableState(state: state, bloc: bloc),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => bloc.dispatchEvent(PeriodEventCreatePeriod(context)),
        label: const Text('Cadastrar Novo Periodo'),
        icon: const Icon(Icons.person_add_alt_outlined),
      ),
    );
  }
}

/*





 */
