import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/utils/date_formatter.dart';
import 'package:ariane_app/features/client_perfurations/presentation/bloc/client_perfurations_bloc.dart';
import 'package:flutter/material.dart';

class ClientPerfurationsViewStableState extends StatefulWidget {
  final BlocState state;
  final Function(String value) onDelete;
  const ClientPerfurationsViewStableState(
      {required this.state, required this.onDelete, super.key});

  @override
  State<ClientPerfurationsViewStableState> createState() =>
      _ClientPerfurationsViewStableStateState();
}

class _ClientPerfurationsViewStableStateState
    extends State<ClientPerfurationsViewStableState> {
  ClientPerfurationsStableData get data => widget.state.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfurações'),
      ),
      body: ListView.builder(
        itemCount: data.perfurations.length,
        itemBuilder: (context, index) {
          final perfuration = data.perfurations[index];
          final typePerfuration = data.perfurations[index].typePerfuration;

          return buildDismissibleCardClientPerfurations(
              typePerfuration, perfuration);
        },
      ),
    );
  }

  void showConfirmationDialog(PerfurationEntity perfuration) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmação"),
          content: const Text("Deseja realmente excluir esta perfuração?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                widget.onDelete(perfuration.id);
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

  Widget buildDismissibleCardClientPerfurations(
    TypePerfurationEntity typePerfuration,
    PerfurationEntity perfuration,
  ) {
    return ListTile(
      title: Text(typePerfuration.name),
      subtitle: Text(
        DateFormatter.ddMMyyyy(
          DateTime.fromMillisecondsSinceEpoch(perfuration.createdAt),
        ),
      ),
      trailing: IconButton(
        onPressed: () => showConfirmationDialog(perfuration),
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ),
      ),
    );
  }
}
