import 'package:flutter/material.dart';

class ShowConfirmationDialog extends StatelessWidget {
  final String message;
  const ShowConfirmationDialog({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atenção'),
      content: Text(message),
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
            child: const Text('Sim'))
      ],
    );
  }
}
