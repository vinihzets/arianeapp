import 'package:ariane_app/core/validators/form_builder_validators.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../domain/entities/client_entity.dart';

class CreateUpdateClientDialog extends StatefulWidget {
  final ClientEntity? client;
  const CreateUpdateClientDialog({required this.client, super.key});

  @override
  State<CreateUpdateClientDialog> createState() =>
      _CreateUpdateClientDialogState();
}

class _CreateUpdateClientDialogState extends State<CreateUpdateClientDialog> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController numberController;
  late TextEditingController birthdayController;
  late MaskTextInputFormatter maskNumberFormatter;
  late MaskTextInputFormatter maskBirthdayFormatter;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    firstNameController = TextEditingController(text: widget.client?.firstName);
    lastNameController = TextEditingController(text: widget.client?.lastName);
    numberController = TextEditingController(
      text: widget.client?.number.toString(),
    );
    maskNumberFormatter = MaskTextInputFormatter(mask: '(##) #####-####');

    maskBirthdayFormatter =
        MaskTextInputFormatter(mask: '##/##/####', initialText: '03/05/1998');
    birthdayController = TextEditingController(text: widget.client?.birthday);

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    numberController.dispose();
    birthdayController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.client == null
                    ? 'Novo Cliente'
                    : 'Atualizar Cliente'),
                const SizedBox(height: 6),
                TextFormField(
                    controller: firstNameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) =>
                        FormBuilderValidator.firstNameValidator(value)),
                TextFormField(
                    controller: lastNameController,
                    decoration: const InputDecoration(labelText: 'Sobrenome'),
                    validator: (value) =>
                        FormBuilderValidator.lastNameValidator(value)),
                TextFormField(
                  inputFormatters: [maskNumberFormatter],
                  controller: numberController,
                  decoration:
                      const InputDecoration(labelText: 'Número de telefone'),
                  validator: (value) =>
                      FormBuilderValidator.numberValidator(value),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                    inputFormatters: [maskBirthdayFormatter],
                    controller: birthdayController,
                    decoration:
                        const InputDecoration(labelText: 'Data de Nascimento'),
                    validator: (value) =>
                        FormBuilderValidator.birthdayValidator(value)),
                const SizedBox(
                  height: 3,
                ),
                ElevatedButton(
                  onPressed: () {
                    final unMaskedNumber =
                        maskNumberFormatter.unmaskText(numberController.text);

                    final unMaskedBirthday = maskBirthdayFormatter
                        .unmaskText(birthdayController.text);

                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop(ClientEntity(
                        id: widget.client?.id ?? '',
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        number: int.parse(unMaskedNumber),
                        birthday: unMaskedBirthday,
                      ));
                    }
                  },
                  child: Text(
                    widget.client == null ? 'Criar' : 'Atualizar',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
