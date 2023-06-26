import 'package:ariane_app/core/architecture/bloc.dart';
import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/utils/const_routes.dart';
import 'package:ariane_app/features/home/domain/usecases/sign_out_usecase_impl.dart';
import 'package:ariane_app/features/home/presentation/bloc/home_event.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc {
  SignOutUseCaseImpl signOutUseCaseImpl;
  ConstRoutes routes;

  HomeBloc(this.signOutUseCaseImpl, this.routes);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is HomeEventSignOut) {
      _handleSignOut(event.context);
    }
  }

  _handleSignOut(BuildContext context) {
    signOutUseCaseImpl.call(NoParams()).then((value) => value.fold((l) {
          showSnack(context, 'Nao foi possivel efetuar o log-out', Colors.red);
        }, (r) => {navigateRemoveUntil(context, routes.loginView)}));
  }
}
