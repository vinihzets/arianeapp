import 'package:ariane_app/core/core.dart';
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

  _handleSignIn(BuildContext context, String email, String password) async {
    final request = await signInUseCaseImpl(SignInParams(email, password));

    request.fold((l) {
      showFailure(context, StringTranslator.build(l.message.toString()));
    }, (r) => navigateRemoveUntil(context, routes.homeView));
  }

  _handleNavigateToRegister(BuildContext context) {
    navigateThenUntil(context, routes.registerView, null);
  }
}
