import 'package:flutter/material.dart';

import '../../domain/entities/type_entity.dart';

class CreateUpdateTypePerfurationDialog extends StatefulWidget {
  final TypePerfurationEntity? typePerfuration;
  const CreateUpdateTypePerfurationDialog({required this.typePerfuration, super.key, TypePerfurationEntity? TypePerfuration});

  @override
  State<CreateUpdateTypePerfurationDialog> createState() =>
      _CreateUpdateTypePerfurationDialogState();
}

class _CreateUpdateTypePerfurationDialogState extends State<CreateUpdateTypePerfurationDialog> {
  late TextEditingController namePerfurationController;
  // late TextEditingController lastNameController;

  @override
  void initState() {
    namePerfurationController = TextEditingController(text: widget.typePerfuration?.namePerfuration);
    // lastNameController = TextEditingController(text: widget.typePerfuration?.lastName);
    // numberController = TextEditingController(
      // text: widget.typePerfuration?.number.toString(),
    // );
    // birthdayController = TextEditingController(text: widget.typePerfuration?.birthday);

    super.initState();
  }

  @override
  void dispose() {
   namePerfurationController.dispose();
    // lastNameController.dispose();
    // numberController.dispose();
    // birthdayController.dispose();

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
            Text(widget.typePerfuration == null ? 'Novo typePerfuratione' : 'Atualizar typePerfuratione'),
            const SizedBox(height: 6),
            SizedBox(
              width: 220,
              child: TextField(
                controller: namePerfurationController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            // SizedBox(
            //   width: 220,
            //   child: TextField(
            //     controller: lastNameController,
            //     decoration: const InputDecoration(labelText: 'Sobrenome'),
            //   ),
            // ),
            // SizedBox(
            //   width: 220,
            //   child: TextField(
            //     controller: numberController,
            //     decoration: const InputDecoration(labelText: 'Numero'),
            //   ),
            // ),
            // SizedBox(
            //   width: 220,
            //   child: TextField(
            //     controller: birthdayController,
            //     decoration:
            //         const InputDecoration(labelText: 'Data de Nascimento'),
            //   ),
            // ),
            const SizedBox(
              height: 3,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(TypePerfurationEntity(
                id: widget.typePerfuration?.id ?? '',
                namePerfuration: namePerfurationController.text,
              
              )),
              child: Text(
                widget.typePerfuration == null ? 'Criar' : 'Atualizar',
              ),
            )
          ],
        ),
      ),
    );
  }
}
