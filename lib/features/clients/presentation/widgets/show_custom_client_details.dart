import 'package:ariane_app/features/clients/clients.dart';
import 'package:flutter/material.dart';

class ShowCustomClientDetails extends StatelessWidget {
  final ClientEntity entity;

  const ShowCustomClientDetails({required this.entity, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nome: ${entity.firstName} ${entity.lastName}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 9.0,
            ),
            Text('Data de Nascimento: ${entity.birthday}',
                style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 9.0,
            ),
            Text('Numero De Telefone: ${entity.number}',
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
