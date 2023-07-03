import 'package:flutter/material.dart';
import '../../../../core/global/entities/period_entity.dart';
import '../widgets/counter_widget.dart';

class CreateUpdatePeriodDialog extends StatefulWidget {
  final PeriodEntity? period;
  const CreateUpdatePeriodDialog({required this.period, super.key});

  @override
  State<CreateUpdatePeriodDialog> createState() =>
      _CreateUpdatePeriodDialogState();
}

class _CreateUpdatePeriodDialogState extends State<CreateUpdatePeriodDialog> {
  late TextEditingController nameController;
  late TextEditingController messageController;
  late int dayCounter;
  late int monthCounter;
  late int yearCounter;

  @override
  void initState() {
    dayCounter = widget.period?.dayCounter ?? 1;
    monthCounter = widget.period?.monthCounter ?? 0;
    yearCounter = widget.period?.yearCounter ?? 0;

    nameController = TextEditingController(text: widget.period?.name);
    messageController = TextEditingController(text: widget.period?.message);

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CounterWidget(
                  label: 'Dia',
                  counter: dayCounter,
                  onAdd: () {
                    dayCounter++;
                    setState(() {});
                  },
                  onRemove: () {
                    dayCounter--;
                    setState(() {});
                  }),
              CounterWidget(
                  label: 'Mes',
                  counter: monthCounter,
                  onAdd: () {
                    monthCounter++;
                    setState(() {});
                  },
                  onRemove: () {
                    monthCounter--;
                    setState(() {});
                  }),
              CounterWidget(
                  label: 'Ano',
                  counter: yearCounter,
                  onAdd: () {
                    yearCounter++;
                    setState(() {});
                  },
                  onRemove: () {
                    setState(() {});
                    yearCounter--;
                  }),
            ],
          ),
          SizedBox(
            width: 260,
            child: TextField(
              controller: nameController,
            ),
          ),
          SizedBox(
            width: 260,
            child: TextField(
              controller: messageController,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(PeriodEntity(
                name: nameController.text,
                message: messageController.text,
                id: widget.period?.id ?? '',
                dayCounter: dayCounter,
                monthCounter: monthCounter,
                yearCounter: yearCounter,
              ));
            },
            child: Text(
              widget.period == null ? 'Criar' : 'Atualizar',
            ),
          )
        ],
      ),
    );
  }
}
