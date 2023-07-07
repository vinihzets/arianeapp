import 'package:ariane_app/features/pending/pending.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/counter_widget.dart';

class CustomSearchPendingDialog extends StatefulWidget {
  final PendingBloc bloc;
  const CustomSearchPendingDialog({required this.bloc, super.key});

  @override
  State<CustomSearchPendingDialog> createState() =>
      _CustomSearchPendingDialogState();
}

class _CustomSearchPendingDialogState extends State<CustomSearchPendingDialog> {
  int dayCounter = 1;
  int monthCounter = 1;
  int yearCounter = 2023;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CounterWidget(
              label: 'Dia',
              counter: dayCounter,
              onAdd: () {
                if (dayCounter > 31) {
                  return;
                }
                dayCounter++;
                setState(() {});
              },
              onRemove: () {
                if (dayCounter < 1) {
                  return;
                }

                dayCounter--;
                setState(() {});
              }),
          CounterWidget(
              label: 'Mes',
              counter: monthCounter,
              onAdd: () {
                if (monthCounter > 11) {
                  return;
                }
                monthCounter++;
                setState(() {});
              },
              onRemove: () {
                if (monthCounter < 1) {
                  return;
                }

                monthCounter--;
                setState(() {});
              }),
          CounterWidget(
              label: 'Ano',
              counter: yearCounter,
              onAdd: () {
                if (yearCounter > 11) {
                  return;
                }
                yearCounter++;
                setState(() {});
              },
              onRemove: () {
                if (yearCounter < 1) {
                  return;
                }
                setState(() {});
                yearCounter--;
              }),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              widget.bloc.dispatchEvent(
                  PendingEventOnReady(dayCounter, monthCounter, yearCounter));
            },
            child: const Text('Pesquisar'))
      ],
    );
  }
}
