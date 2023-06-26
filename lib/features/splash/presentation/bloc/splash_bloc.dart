import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import 'splash_event.dart';

class SplashBloc extends Bloc {
  ConstRoutes routes;
  AuthService authService;

  SplashBloc(this.routes, this.authService);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is SplashEventAuthentication) {
      _handleAuthentication(event.context);
    }
  }

  _handleAuthentication(BuildContext context) {
    dispatchState(BlocLoadingState());
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (authService.auth.currentUser != null) {
        navigateRemoveUntil(context, routes.homeView);
      } else {
        navigateRemoveUntil(context, routes.loginView);
      }
    });
  }
}
