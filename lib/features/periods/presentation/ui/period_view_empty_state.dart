import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';

class PeriodViewEmptyState extends StatelessWidget {
  final BlocState state;
  const PeriodViewEmptyState({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nenhum periodo cadastrado.'),
          Icon(
            Icons.person_add_disabled_outlined,
            size: 89,
          )
        ],
      ),
    );
  }
}
