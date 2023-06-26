import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:ariane_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';

import '../bloc/splash_event.dart';

class SplashViewEmptyState extends StatelessWidget {
  final BlocState state;
  final SplashBloc bloc;
  const SplashViewEmptyState(
      {required this.state, required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            bloc.dispatchEvent(SplashEventAuthentication(context));
          },
          child: const Text('Tentar Novamente')),
    );
  }
}
