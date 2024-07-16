import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/drawer/presentation/bloc/custom_drawer_bloc.dart';
import 'package:ariane_app/core/drawer/presentation/bloc/custom_drawer_event.dart';
import 'package:ariane_app/core/drawer/presentation/ui/states/custom_drawer_stable_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ConstRoutes routes;
  late CustomDrawerBloc bloc;

  @override
  void initState() {
    routes = GetIt.I.get();

    bloc = GetIt.I.get();

    bloc.dispatchEvent(FetchSessionEvent(context: context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: BlocScreenBuilder(
              stream: bloc.state,
              onStable: (s) => CustomDrawerStableState(
                    routes: routes,
                    state: s,
                  ),
              onError: (s) => Container(),
              onLoading: (s) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
              onEmpty: (s) => Container())),
    );
  }
}
