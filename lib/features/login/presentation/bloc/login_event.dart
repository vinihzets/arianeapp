import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:flutter/widgets.dart';

class LoginEvent extends BlocEvent {}

class LoginEventOnReady implements LoginEvent {}

class LoginEventSignIn implements LoginEvent {
  BuildContext context;
  String email;
  String password;

  LoginEventSignIn(this.context, this.email, this.password);
}

class LoginEventNavigateToRegisterThenUntil implements LoginEvent {
  BuildContext context;

  LoginEventNavigateToRegisterThenUntil(this.context);
}
