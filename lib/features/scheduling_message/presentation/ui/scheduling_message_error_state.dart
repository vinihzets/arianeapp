import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_bloc.dart';
import 'package:ariane_app/features/scheduling_message/presentation/bloc/scheduling_message_event.dart';
import 'package:flutter/material.dart';

class SchedulingMessageViewErrorState extends StatelessWidget {
  final SchedulingMessageBloc bloc;
  final int fetchAmmount = 10;
  const SchedulingMessageViewErrorState({required this.bloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () => bloc.dispatchEvent(
              SchedulingMessageEventRead(date: DateTime.now(), ammount: 10)),
          child: const Text("Tente novamente")),
    );
  }
}
