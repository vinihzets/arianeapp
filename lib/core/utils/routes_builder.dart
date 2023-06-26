import 'package:ariane_app/core/utils/const_routes.dart';
import 'package:ariane_app/features/home/presentation/ui/home_view.dart';
import 'package:ariane_app/features/login/presentation/ui/login_view.dart';
import 'package:ariane_app/features/register/presentation/ui/register_view.dart';
import 'package:ariane_app/features/splash/presentation/ui/splash_view.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:flutter/material.dart';

class RoutesBuilder {
  static build(ConstRoutes routes) {
    return <String, WidgetBuilder>{
      routes.splashView: (context) => const SplashView(),
      routes.loginView: (_) => const LoginView(),
      routes.homeView: (_) => const HomeView(),
      routes.registerView: (_) => const RegisterView(),
      routes.typePerfurationView: (_) => const TypePerfurationView()
    };
  }
}
