import 'package:ariane_app/core/global/entities/period_entity.dart';
import 'package:flutter/material.dart';

class ShowCustomPeriodsDetails extends StatelessWidget {
  final PeriodEntity entity;

  const ShowCustomPeriodsDetails({required this.entity, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nome: ${entity.name}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 9.0,
            ),
            Text('Data de Nascimento: ${entity.message}',
                style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 9.0,
            ),
          ],
        ),
      ),
    );
  }
}
