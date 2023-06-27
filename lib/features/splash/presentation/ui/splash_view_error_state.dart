import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:ariane_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:ariane_app/features/splash/presentation/bloc/splash_event.dart';
import 'package:flutter/material.dart';

class SplashViewErrorState extends StatelessWidget {
  final BlocState state;
  final SplashBloc bloc;
  const SplashViewErrorState(
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
