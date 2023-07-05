import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';

class ClientViewEmptyState extends StatelessWidget {
  final BlocState state;
  const ClientViewEmptyState({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nenhum cliente cadastrado ainda.'),
          Icon(
            Icons.person_add_disabled_outlined,
            size: 89,
          )
        ],
      ),
    );
  }
}
