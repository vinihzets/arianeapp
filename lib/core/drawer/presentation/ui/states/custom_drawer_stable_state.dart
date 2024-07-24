import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/drawer/presentation/widgets/custom_drawer_tile.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class CustomDrawerStableState extends StatefulWidget {
  final ConstRoutes routes;
  final BlocState state;
  const CustomDrawerStableState(
      {required this.routes, required this.state, super.key});

  @override
  State<CustomDrawerStableState> createState() =>
      _CustomDrawerStableStateState();
}

class _CustomDrawerStableStateState extends State<CustomDrawerStableState> {
  ConstRoutes get routes => widget.routes;
  BlocState get state => widget.state;
  UserEntity get user => widget.state.data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomDrawerTile(
            title: 'Home',
            trailing: const Icon(Icons.arrow_right),
            leading: const Icon(Icons.home),
            route: routes.homeView,
          ),
          CustomDrawerTile(
            title: 'Tipo de Perfuração',
            trailing: const Icon(Icons.arrow_right),
            leading: const Icon(Icons.edit),
            route: routes.typePerfurationView,
          ),
          CustomDrawerTile(
            title: 'Periodos',
            trailing: const Icon(Icons.arrow_right),
            leading: const Icon(Icons.pending_actions_rounded),
            route: routes.periodsView,
          ),
          user.role == UserRole.admin
              ? CustomDrawerTile(
                  title: 'Usuários',
                  trailing: const Icon(Icons.arrow_right),
                  leading: const Icon(Icons.supervised_user_circle_sharp),
                  route: routes.users,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
