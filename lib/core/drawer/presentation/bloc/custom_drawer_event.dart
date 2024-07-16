import 'package:ariane_app/core/core.dart';
import 'package:flutter/material.dart';

class CustomDrawerEvent extends BlocEvent {}

class FetchSessionEvent implements CustomDrawerEvent {
  final BuildContext context;

  FetchSessionEvent({required this.context});
}
