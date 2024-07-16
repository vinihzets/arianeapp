import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/usecases/fetch_users_usecase_impl.dart';
import 'package:ariane_app/features/users/presentation/bloc/users_event.dart';
import 'package:flutter/material.dart';

class UsersBloc extends Bloc {
  FetchUsersUseCaseImpl fetchUsersUseCaseImpl;

  UsersBloc(this.fetchUsersUseCaseImpl);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is FetchUsersEvent) {
      _handleFetchUsers(event.context);
    }
  }

  _handleFetchUsers(final BuildContext context) async {
    final request = await fetchUsersUseCaseImpl.call(FetchUsersParams());

    request.fold((l) => showFailure(context, l.message),
        (r) => dispatchState(BlocStableState(data: r)));
  }
}
