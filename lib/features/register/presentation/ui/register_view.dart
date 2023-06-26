import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/core.dart';
import '../../register.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late RegisterBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();

    bloc.dispatchEvent(RegisterEventOnReady());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
          stream: bloc.state,
          onStable: (onStable) =>
              RegisterViewStableState(state: onStable, bloc: bloc),
          onError: (onError) => const SizedBox.shrink(),
          onLoading: (onLoading) => const SizedBox.shrink(),
          onEmpty: (onEmpty) => const SizedBox.shrink()),
    );
  }
}
