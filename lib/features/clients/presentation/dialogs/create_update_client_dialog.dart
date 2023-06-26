import 'package:flutter/material.dart';

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

  @override
  void initState() {
    firstNameController = TextEditingController(text: widget.client?.firstName);
    lastNameController = TextEditingController(text: widget.client?.lastName);
    numberController = TextEditingController(
      text: widget.client?.number.toString(),
    );
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.client == null ? 'Novo Cliente' : 'Atualizar Cliente'),
            const SizedBox(height: 6),
            SizedBox(
              width: 220,
              child: TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: 220,
              child: TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Sobrenome'),
              ),
            ),
            SizedBox(
              width: 220,
              child: TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: 'Numero'),
              ),
            ),
            SizedBox(
              width: 220,
              child: TextField(
                controller: birthdayController,
                decoration:
                    const InputDecoration(labelText: 'Data de Nascimento'),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(ClientEntity(
                id: widget.client?.id ?? '',
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                number: int.parse(numberController.text),
                birthday: birthdayController.text,
              )),
              child: Text(
                widget.client == null ? 'Criar' : 'Atualizar',
              ),
            )
          ],
        ),
      ),
    );
  }
}
