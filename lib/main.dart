import 'package:ariane_app/core/configs/firebase_initialize.dart';
import 'package:ariane_app/core/injector/injector.dart';
import 'package:ariane_app/core/utils/const_routes.dart';
import 'package:ariane_app/core/utils/routes_builder.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  await FirebaseInitialize.build();

  Injector.build();

  late ConstRoutes routes;

  routes = GetIt.I.get();

  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    initialRoute: routes.splashView,
    routes: RoutesBuilder.build(routes),
  ));
}
