import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/widgets.dart';

class SplashViewStableState extends StatefulWidget {
  final BlocState state;
  const SplashViewStableState({required this.state, super.key});

  @override
  State<SplashViewStableState> createState() => _SplashViewStableStateState();
}

class _SplashViewStableStateState extends State<SplashViewStableState> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
