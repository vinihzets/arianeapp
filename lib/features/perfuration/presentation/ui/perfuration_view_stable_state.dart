import 'dart:developer';

import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';
import '../../perfurations.dart';

enum PerfurationMenuAction {
  delete,
  update,
}

class PerfurationViewStableState extends StatefulWidget {
  final BlocState state;
  final PerfurationsBloc bloc;
  const PerfurationViewStableState(
      {required this.state, required this.bloc, super.key});

  @override
  State<PerfurationViewStableState> createState() =>
      _PerfurationViewStableStateState();
}

class _PerfurationViewStableStateState
    extends State<PerfurationViewStableState> {
  @override
  Widget build(BuildContext context) {
    List<PerfurationEntity> listPerfurations = widget.state.data;

    return ListView.builder(
      itemCount: listPerfurations.length,
      itemBuilder: (context, index) {
        final Perfuration = listPerfurations[index];
        return ListTile(
            leading: Text(Perfuration.name),
            trailing: PopupMenuButton<PerfurationMenuAction>(
              itemBuilder: (_) => [
                const PopupMenuItem<PerfurationMenuAction>(
                  value: PerfurationMenuAction.delete,
                  child: Text('Apagar'),
                ),
                const PopupMenuItem<PerfurationMenuAction>(
                  value: PerfurationMenuAction.update,
                  child: Text('Atualizar'),
                ),
              ],
              onSelected: (action) {
                switch (action) {
                  case PerfurationMenuAction.delete:
                    widget.bloc.dispatchEvent(PerfurationEventDeletePerfuration(
                        context, Perfuration));
                    break;
                  case PerfurationMenuAction.update:
                    widget.bloc.dispatchEvent(PerfurationEventUpdatePerfuration(
                        context, Perfuration));
                    break;
                }
              },
            ));
      },
    );
  }
}
