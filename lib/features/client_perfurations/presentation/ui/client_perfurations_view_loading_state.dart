import 'package:flutter/material.dart';

class ClientPerfurationsViewLoadingState extends StatelessWidget {
  const ClientPerfurationsViewLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
