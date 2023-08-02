import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';

class TypePerfurationViewLoadingState extends StatelessWidget {
  final BlocState state;
  const TypePerfurationViewLoadingState({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
