import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';

class PerfurationViewLoadingState extends StatelessWidget {
  final BlocState state;
  const PerfurationViewLoadingState({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
