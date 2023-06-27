import 'package:ariane_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:ariane_app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';

class LoginViewStableData extends StatefulWidget {
  final LoginBloc bloc;

  const LoginViewStableData({required this.bloc, super.key});

  @override
  State<LoginViewStableData> createState() => _LoginViewStableDataState();
}

class _LoginViewStableDataState extends State<LoginViewStableData> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 260,
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                controller: emailController,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            SizedBox(
              width: 260,
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                controller: passwordController,
                obscuringCharacter: '*',
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            ElevatedButton(
              onPressed: () => widget.bloc.dispatchEvent(LoginEventSignIn(
                  context, emailController.text, passwordController.text)),
              child: const Text('Fazer Login'),
            ),
            TextButton(
                onPressed: () => widget.bloc.dispatchEvent(
                    LoginEventNavigateToRegisterThenUntil(context)),
                child: const Text(
                  'Registrar-se',
                ))
          ]),
    );
  }
}
