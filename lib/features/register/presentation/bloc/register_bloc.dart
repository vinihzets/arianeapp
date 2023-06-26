import 'package:ariane_app/core/architecture/bloc.dart';
import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/utils/string_translator.dart';
import 'package:ariane_app/features/register/domain/usecases/sign_up_usecase_impl.dart';
import 'package:ariane_app/features/register/presentation/bloc/register_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterBloc extends Bloc {
  SignUpUseCaseImpl signUpUseCaseImpl;

  RegisterBloc(this.signUpUseCaseImpl);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is RegisterEventOnReady) {
      dispatchState(BlocStableState());
    } else if (event is RegisterEventSignUp) {
      _handleSignUp(event.context, event.email, event.password);
    } else if (event is RegisterEventNavigatePop) {
      navigatePop(event.context);
    }
  }

  _handleSignUp(BuildContext context, String email, String password) async {
    await signUpUseCaseImpl(SignUpParams(email, password)).then((value) =>
        value.fold(
            (l) => showSnack(
                context, StringTranslator.build(l.message), Colors.red),
            (r) =>
                {showSnack(context, 'Cadastrou com sucesso', Colors.green)}));
  }
}
