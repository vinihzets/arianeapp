import 'package:ariane_app/core/architecture/bloc.dart';
import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/utils/const_routes.dart';
import 'package:ariane_app/core/utils/string_translator.dart';
import 'package:ariane_app/features/login/domain/usecases/sign_in_usecase_impl.dart';
import 'package:ariane_app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';

class LoginBloc extends Bloc {
  SignInUseCaseImpl signInUseCaseImpl;
  ConstRoutes routes;
  LoginBloc(this.signInUseCaseImpl, this.routes);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is LoginEventOnReady) {
      dispatchState(BlocStableState());
    } else if (event is LoginEventSignIn) {
      _handleSignIn(event.context, event.email, event.password);
    } else if (event is LoginEventNavigateToRegisterThenUntil) {
      _handleNavigateToRegister(event.context);
    }
  }

  _handleSignIn(BuildContext context, String email, String password) {
    signInUseCaseImpl(SignInParams(email, password)).then((value) => value.fold(
            (l) => showSnack(
                context, StringTranslator.build(l.message), Colors.red), (r) {
          navigateRemoveUntil(context, routes.homeView);
        }));
  }

  _handleNavigateToRegister(BuildContext context) {
    navigateThenUntil(context, routes.registerView);
  }
}
