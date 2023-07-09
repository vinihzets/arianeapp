import 'package:ariane_app/features/pending/pending.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/counter_widget.dart';

// ignore: must_be_immutable
class CustomSearchPendingDialog extends StatefulWidget {
  int dayCounter;
  int monthCounter;
  int yearCounter;

  final PendingBloc bloc;
  CustomSearchPendingDialog(
      {required this.bloc,
      required this.dayCounter,
      required this.monthCounter,
      required this.yearCounter,
      super.key});

  @override
  State<CustomSearchPendingDialog> createState() =>
      _CustomSearchPendingDialogState();
}

class _CustomSearchPendingDialogState extends State<CustomSearchPendingDialog> {
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
              counter: widget.dayCounter,
              onAdd: () {
                if (widget.dayCounter > 31) {
                  return;
                }
                widget.dayCounter++;
                setState(() {});
              },
              onRemove: () {
                if (widget.dayCounter < 1) {
                  return;
                }

                widget.dayCounter--;
                setState(() {});
              }),
          CounterWidget(
              label: 'Mes',
              counter: widget.monthCounter,
              onAdd: () {
                if (widget.monthCounter > 11) {
                  return;
                }
                widget.monthCounter++;
                setState(() {});
              },
              onRemove: () {
                if (widget.monthCounter < 1) {
                  return;
                }

                widget.monthCounter--;
                setState(() {});
              }),
          CounterWidget(
              label: 'Ano',
              counter: widget.yearCounter,
              onAdd: () {
                if (widget.yearCounter > 11) {
                  return;
                }
                widget.yearCounter++;
                setState(() {});
              },
              onRemove: () {
                if (widget.yearCounter < 1) {
                  return;
                }
                setState(() {});
                widget.yearCounter--;
              }),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              widget.bloc.dispatchEvent(PendingEventOnReady(
                  widget.dayCounter, widget.monthCounter, widget.yearCounter));
            },
            child: const Text('Pesquisar'))
      ],
    );
  }
}
