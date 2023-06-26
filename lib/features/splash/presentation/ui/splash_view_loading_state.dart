import 'package:flutter/material.dart';

import '../../../../core/architecture/bloc_state.dart';

class SplashViewLoadingState extends StatelessWidget {
  final BlocState state;
  const SplashViewLoadingState({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    print('teste');
    return const Center(child: CircularProgressIndicator());
  }
}
