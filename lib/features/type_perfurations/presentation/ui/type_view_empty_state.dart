import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';

class TypePerfurationViewEmptyState extends StatelessWidget {
  final BlocState state;
  const TypePerfurationViewEmptyState({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nenhuma perfuração cadastrado.'),
          Icon(
            Icons.person_add_disabled_outlined,
            size: 89,
          )
        ],
      ),
    );
  }
}
