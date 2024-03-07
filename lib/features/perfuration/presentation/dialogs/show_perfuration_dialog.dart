import 'package:flutter/material.dart';

class ShowConfirmationPerfurationDialog extends StatelessWidget {
  const ShowConfirmationPerfurationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atenção'),
      content: const Text('Você deseja realmente adicionar essa perfuração?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Sim'),
        )
      ],
    );
  }
}
