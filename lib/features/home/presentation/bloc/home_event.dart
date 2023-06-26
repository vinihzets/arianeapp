import 'package:ariane_app/core/architecture/bloc_event.dart';
import 'package:flutter/material.dart';

class HomeEvent extends BlocEvent {}

class HomeEventSignOut implements HomeEvent {
  BuildContext context;

  HomeEventSignOut(this.context);
}
