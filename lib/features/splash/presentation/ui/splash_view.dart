import 'package:ariane_app/core/components/bloc_screen_builder.dart';
import 'package:ariane_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:ariane_app/features/splash/presentation/bloc/splash_event.dart';
import 'package:ariane_app/features/splash/presentation/ui/splash_view_empty_state.dart';
import 'package:ariane_app/features/splash/presentation/ui/splash_view_error_state.dart';
import 'package:ariane_app/features/splash/presentation/ui/splash_view_loading_state.dart';
import 'package:ariane_app/features/splash/presentation/ui/splash_view_stable_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashBloc bloc;
  @override
  void initState() {
    bloc = GetIt.I.get();
    bloc.dispatchEvent(SplashEventAuthentication(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocScreenBuilder(
          stream: bloc.state,
          onStable: (onStable) => SplashViewStableState(
                state: onStable,
              ),
          onError: (onError) =>
              SplashViewErrorState(state: onError, bloc: bloc),
          onLoading: (onLoading) => SplashViewLoadingState(
                state: onLoading,
              ),
          onEmpty: (onEmpty) =>
              SplashViewEmptyState(state: onEmpty, bloc: bloc)),
    );
  }
}
