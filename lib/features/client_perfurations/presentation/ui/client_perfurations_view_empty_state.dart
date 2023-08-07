import 'package:flutter/material.dart';

class ClientPerfurationsViewEmptyState extends StatelessWidget {
  const ClientPerfurationsViewEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Este usuario não tem nenhuma perfuração cadastrada ainda.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
