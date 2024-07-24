import 'package:ariane_app/core/validators/form_builder_validators.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../domain/entities/client_entity.dart';

class CreateUpdateClientDialog extends StatefulWidget {
  final UserEntity user;
  final ClientEntity? client;
  const CreateUpdateClientDialog({
    required this.user,
    required this.client,
    super.key,
  });

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
    birthdayController = TextEditingController(text: widget.client?.birthday);
    numberController = TextEditingController(
      text: widget.client?.number,
    );

    maskNumberFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      initialText: widget.client?.number ?? '(62) 98642-4219',
    );
    maskBirthdayFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      initialText: widget.client?.birthday ?? '03/05/1998',
    );

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
    return AlertDialog(
      title: Text(widget.client == null ? 'Novo Cliente' : 'Atualizar Cliente'),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop(ClientEntity(
                id: widget.client?.id ?? '',
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                number: numberController.text,
                birthday: birthdayController.text,
                userId: widget.user.id,
              ));
            }
          },
          child: Text(
            widget.client == null ? 'Criar' : 'Atualizar',
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
