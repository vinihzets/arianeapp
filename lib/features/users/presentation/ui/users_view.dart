import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/drawer/presentation/ui/custom_drawer.dart';
import 'package:ariane_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:ariane_app/features/users/presentation/bloc/users_event.dart';
import 'package:ariane_app/features/users/presentation/ui/states/users_view_stable_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  late UsersBloc bloc;

  @override
  void initState() {
    bloc = GetIt.I.get();

    bloc.dispatchEvent(FetchUsersEvent(context: context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(),
      body: BlocScreenBuilder(
          stream: bloc.state,
          onStable: (s) => UsersViewStableState(
                state: s,
              ),
          onError: (s) => Container(),
          onLoading: (s) => Container(),
          onEmpty: (s) => Container()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => bloc.dispatchEvent(CreateUserEvent(context: context)),
        label: const Text('Novo Usuário'),
        icon: const Icon(Icons.person_add_alt_outlined),
      ),
    );
  }
}
