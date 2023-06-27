import 'dart:developer';

import 'package:ariane_app/features/periods/periods.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/core.dart';
import '../../type_perfurations.dart';

class TypePerfurationView extends StatefulWidget {
  const TypePerfurationView({super.key});

  @override
  State<TypePerfurationView> createState() => _TypePerfurationViewState();
}

class _TypePerfurationViewState extends State<TypePerfurationView> {
  late TypePerfurationsBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();

    bloc.dispatchEvent(TypePerfurationEventReadTypePerfuration());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
        stream: bloc.state,
        onEmpty: (state) => TypePerfurationViewEmptyState(state: state),
        onError: (state) => TypePerfurationViewErrorState(
          state: state,
        ),
        onLoading: (state) => TypePerfurationViewLoadingState(state: state),
        onStable: (state) =>
            TypePerfurationViewStableState(state: state, bloc: bloc),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => bloc
            .dispatchEvent(TypePerfurationEventCreateTypePerfuration(context)),
        label: const Text('Novo Tipo de Perfuração'),
        icon: const Icon(Icons.person_add_alt_outlined),
      ),
    );
  }
}

/*





 */
