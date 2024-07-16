import 'package:ariane_app/core/core.dart';
import 'package:flutter/material.dart';

class UsersEvent extends BlocEvent {}

class FetchUsersEvent implements UsersEvent {
  final BuildContext context;

  FetchUsersEvent({required this.context});
}
