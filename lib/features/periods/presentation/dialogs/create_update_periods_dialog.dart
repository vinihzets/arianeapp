import 'package:ariane_app/core/validators/form_builder_validators.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Form(
      key: _formKey,
      child: AlertDialog(
        title:
            Text(widget.period == null ? 'Criar periodo' : 'Atualizar periodo'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
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
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nome'),
                validator: (v) =>
                    FormBuilderValidator.customMinLengthValidator(v),
                controller: nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Mensagem'),
                validator: (value) =>
                    FormBuilderValidator.customMinLengthValidator(value),
                controller: messageController,
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? true) {
                if (dayCounter == 0 && monthCounter == 0 && yearCounter == 0) {
                  return;
                }
                Navigator.of(context).pop(PeriodEntity(
                  name: nameController.text,
                  message: messageController.text,
                  id: widget.period?.id ?? '',
                  dayCounter: dayCounter,
                  monthCounter: monthCounter,
                  yearCounter: yearCounter,
                ));
              }
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
