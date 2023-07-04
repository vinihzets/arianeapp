import 'package:flutter/material.dart';

import '../../../../core/architecture/bloc_state.dart';
import '../../periods.dart';

enum PeriodsMenuAction {
  delete,
  update,
  read,
}

class PeriodsViewStableState extends StatefulWidget {
  final BlocState state;
  final PeriodsBloc bloc;
  const PeriodsViewStableState(
      {required this.state, required this.bloc, super.key});

  @override
  State<PeriodsViewStableState> createState() => _PeriodsViewStableStateState();
}

class _PeriodsViewStableStateState extends State<PeriodsViewStableState> {
  @override
  Widget build(BuildContext context) {
    List<PeriodEntity> listPeriods = widget.state.data;

    return ListView.builder(
      itemCount: listPeriods.length,
      itemBuilder: (context, index) {
        final periods = listPeriods[index];
        return ListTile(
            leading: Text(
              periods.name,
            ),
            trailing: PopupMenuButton<PeriodsMenuAction>(
              itemBuilder: (_) => [
                const PopupMenuItem<PeriodsMenuAction>(
                  value: PeriodsMenuAction.delete,
                  child: Text('Apagar'),
                ),
                const PopupMenuItem<PeriodsMenuAction>(
                  value: PeriodsMenuAction.update,
                  child: Text('Atualizar'),
                ),
                const PopupMenuItem<PeriodsMenuAction>(
                  value: PeriodsMenuAction.read,
                  child: Text('Visualizar'),
                ),
              ],
              onSelected: (action) {
                switch (action) {
                  case PeriodsMenuAction.delete:
                    widget.bloc.dispatchEvent(
                        PeriodEventDeletePeriod(context, periods));
                    break;
                  case PeriodsMenuAction.update:
                    widget.bloc.dispatchEvent(
                        PeriodEventUpdatePeriod(context, periods));
                    break;
                  case PeriodsMenuAction.read:
                    showDialog(
                        context: context,
                        builder: (context) =>
                            ShowCustomPeriodsDetails(entity: periods));
                }
              },
            ));
      },
    );
  }
}
