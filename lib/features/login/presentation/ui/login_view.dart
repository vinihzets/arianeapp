import 'package:ariane_app/features/login/presentation/bloc/login_event.dart';
import 'package:ariane_app/features/login/presentation/ui/login_view_stable_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/components/bloc_screen_builder.dart';
import '../bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late LoginBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.dispatchEvent(LoginEventOnReady());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
          onEmpty: (onEmpty) => const SizedBox.shrink(),
          onError: (onError) => const SizedBox.shrink(),
          onLoading: (onLoading) => const SizedBox.shrink(),
          onStable: (onStable) => LoginViewStableData(
                bloc: bloc,
              ),
          stream: bloc.state),
    );
  }
}
