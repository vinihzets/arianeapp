import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/domain/usecases/update_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/create_user_usecase_impl.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';
import 'package:ariane_app/features/users/presentation/bloc/users_event.dart';
import 'package:ariane_app/features/users/presentation/ui/widgets/create_user_dialog.dart';
import 'package:flutter/material.dart';

class UsersBloc extends Bloc {
  FetchUsersUseCaseImpl fetchUsersUseCaseImpl;
  CreateUserUseCaseImpl createUserUseCaseImpl;
  UpdateUserUseCaseImpl updateUserUseCaseImpl;

  late List<UserEntity> users;
  UsersBloc(
    this.fetchUsersUseCaseImpl,
    this.createUserUseCaseImpl,
    this.updateUserUseCaseImpl,
  );

  @override
  mapListenEvent(BlocEvent event) {
    if (event is FetchUsersEvent) {
      _handleFetchUsers(event);
    } else if (event is CreateUserEvent) {
      _handleCreateUser(event);
    } else if (event is UpdateUserEvent) {
      _handleUpdateUser(event);
    }
  }

  _handleFetchUsers(FetchUsersEvent event) async {
    final request = await fetchUsersUseCaseImpl.call(FetchUsersParams());

    request.fold((l) => showFailure(event.context, l.message), (r) {
      users = r;

      dispatchState(BlocStableState(data: users));
    });
  }

  _handleCreateUser(CreateUserEvent event) async {
    final UserEntity? user = await showDialog(
        context: event.context, builder: (context) => const CreateUserDialog());

    if (user == null) {
      return;
    }

    final request = await createUserUseCaseImpl.call(CreateUserParams(
        email: user.email,
        password: user.password ?? '',
        role: user.role,
        date: user.date));

    request.fold((l) => showFailure(event.context, l.message), (r) {
      users.add(r);
      dispatchState(BlocStableState(data: users));
    });
  }

  _handleUpdateUser(UpdateUserEvent event) async {
    final index = users.indexWhere((user) => event.user.id == user.id);

    final request = await updateUserUseCaseImpl.call(UpdateUserParams(
        id: event.user.id, role: event.user.role, date: event.user.date));

    request.fold((l) => showFailure(event.context, l.message), (r) {
      users.removeAt(index);

      users.insert(index, event.user);
      dispatchState(BlocStableState(data: users));
    });
  }
}
