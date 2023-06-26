import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';

class ClientViewLoadingState extends StatelessWidget {
  final BlocState state;
  const ClientViewLoadingState({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
