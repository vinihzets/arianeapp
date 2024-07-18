import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UsersEvent extends BlocEvent {}

class FetchUsersEvent implements UsersEvent {
  final BuildContext context;

  FetchUsersEvent({required this.context});
}

class CreateUserEvent implements UsersEvent {
  final BuildContext context;

  CreateUserEvent({required this.context});
}

class ChangeUserRoleEvent implements UsersEvent {
  final BuildContext context;
  final UserEntity user;

  ChangeUserRoleEvent({
    required this.context,
    required this.user,
  });
}
