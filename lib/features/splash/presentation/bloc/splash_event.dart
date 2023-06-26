import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:flutter/material.dart';

class SplashEvent extends BlocEvent {}

class SplashEventAuthentication implements SplashEvent {
  BuildContext context;

  SplashEventAuthentication(this.context);
}
