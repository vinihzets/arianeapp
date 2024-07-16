import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/drawer/domain/usecases/fetch_user_session_usecase_impl.dart';
import 'package:ariane_app/core/drawer/presentation/bloc/custom_drawer_event.dart';

class CustomDrawerBloc extends Bloc {
  FetchUserSessionUseCaseImpl fetchUserSessionUseCaseImpl;

  CustomDrawerBloc(this.fetchUserSessionUseCaseImpl);

  @override
  mapListenEvent(BlocEvent event) {
    if (event is FetchSessionEvent) {
      _handleFetchSession(event);
    }
  }

  _handleFetchSession(FetchSessionEvent event) async {
    final request =
        await fetchUserSessionUseCaseImpl.call(FetchUserSessionParams());

    request.fold((l) => showFailure(event.context, l.message),
        (r) => dispatchState(BlocStableState(data: r)));
  }
}
