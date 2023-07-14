import 'package:flutter/material.dart';

class LoginViewLoadingState extends StatelessWidget {
  const LoginViewLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
