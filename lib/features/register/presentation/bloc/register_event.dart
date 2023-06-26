import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:flutter/widgets.dart';

class RegisterEvent extends BlocEvent {}

class RegisterEventOnReady implements RegisterEvent {}

class RegisterEventSignUp implements RegisterEvent {
  BuildContext context;
  String email;
  String password;

  RegisterEventSignUp(this.context, this.email, this.password);
}

class RegisterEventNavigatePop implements RegisterEvent {
  BuildContext context;

  RegisterEventNavigatePop(this.context);
}
