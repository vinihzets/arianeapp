import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:ariane_app/features/register/presentation/bloc/register_bloc.dart';
import 'package:ariane_app/features/register/presentation/bloc/register_event.dart';
import 'package:flutter/material.dart';

class RegisterViewStableState extends StatefulWidget {
  final BlocState state;
  final RegisterBloc bloc;
  const RegisterViewStableState(
      {required this.state, required this.bloc, super.key});

  @override
  State<RegisterViewStableState> createState() =>
      _RegisterViewStableStateState();
}

class _RegisterViewStableStateState extends State<RegisterViewStableState> {
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
            const Text(
              'Cadastro',
              style: TextStyle(fontSize: 26),
            ),
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
              onPressed: () => widget.bloc.dispatchEvent(RegisterEventSignUp(
                  context, emailController.text, passwordController.text)),
              child: const Text('Cadastrar-se'),
            ),
            TextButton(
                onPressed: () => widget.bloc
                    .dispatchEvent(RegisterEventNavigatePop(context)),
                child: const Text(
                  'Login',
                ))
          ]),
    );
  }
}
