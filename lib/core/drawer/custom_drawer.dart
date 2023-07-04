import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/utils/const_routes.dart';
import 'custom_drawer_tile.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late ConstRoutes routes;

  @override
  void initState() {
    routes = GetIt.I.get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomDrawerTile(
                title: 'Home',
                trailing: const Icon(Icons.arrow_right),
                leading: const Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushNamed(routes.homeView);
                }),
            CustomDrawerTile(
                title: 'Tipo de Perfuração',
                trailing: const Icon(Icons.arrow_right),
                leading: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(routes.typePerfurationView);
                }),
            CustomDrawerTile(
                title: 'Periodos',
                trailing: const Icon(Icons.arrow_right),
                leading: const Icon(Icons.pending_actions_rounded),
                onPressed: () {
                  Navigator.of(context).pushNamed(routes.periodsView);
                }),
          ],
        ),
      ),
    );
  }
}
