import 'package:flutter/material.dart';

class CustomListClientViewEmptyState extends StatelessWidget {
  const CustomListClientViewEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nenhum cliente com esse nome encontrado'),
          Icon(
            Icons.person_2_outlined,
            size: 89,
          )
        ],
      ),
    );
  }
}
