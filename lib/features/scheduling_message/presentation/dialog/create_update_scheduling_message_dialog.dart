import 'package:ariane_app/core/validators/form_builder_validators.dart';
import 'package:ariane_app/features/scheduling_message/domain/entities/scheduling_message_entity.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CreateUpdateSchedulingMessageDialog extends StatefulWidget {
  final SchedulingMessageEntity? schedulingMessageEntity;
  const CreateUpdateSchedulingMessageDialog(
      {required this.schedulingMessageEntity, super.key});

  @override
  State<CreateUpdateSchedulingMessageDialog> createState() =>
      _CreateUpdateSchedulingMessageDialogState();
}

class _CreateUpdateSchedulingMessageDialogState
    extends State<CreateUpdateSchedulingMessageDialog> {
  late TextEditingController message;
  late String date;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SchedulingMessageBloc bloc;
  DateTime? dateNow;

  @override
  void initState() {
    bloc = GetIt.I.get();
    message =
        TextEditingController(text: widget.schedulingMessageEntity?.message);

    super.initState();
  }

  @override
  void dispose() {
    message.dispose();

    super.dispose();
  }

  onDataPressed() async {
    final result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

    if (result == null) {
      return;
    }
    date = result.millisecondsSinceEpoch.toString();
    dateNow = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.schedulingMessageEntity == null
          ? 'Novo agendamento de mensagem'
          : 'Atualizar mensagem agendada'),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextButton(
                    onPressed: () => onDataPressed(),
                    child: const Text('Agendar Data')),
                TextFormField(
                    controller: message,
                    decoration: const InputDecoration(labelText: 'Mensagem'),
                    validator: (value) =>
                        FormBuilderValidator.messageValidator(value)),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop(SchedulingMessageEntity(
                  id: widget.schedulingMessageEntity?.id ?? '',
                  createdAt: DateTime.now(),
                  message:
                      widget.schedulingMessageEntity?.message ?? message.text,
                  listClients: [],
                  date: date));
            }
          },
          child: Text(
            widget.schedulingMessageEntity == null ? 'Criar' : 'Atualizar',
          ),
        )
      ],
    );
  }

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
