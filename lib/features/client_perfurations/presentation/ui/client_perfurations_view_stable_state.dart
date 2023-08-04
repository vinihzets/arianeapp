import 'package:ariane_app/core/core.dart';
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

  Widget buildDismissibleCardClientPerfurations(
      TypePerfurationEntity typePerfuration, PerfurationEntity perfuration) {
    return Dismissible(
      key: Key(typePerfuration.id),
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      confirmDismiss: (DismissDirection direction) async {
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
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    widget.onDelete(perfuration.id);
                  },
                  child: const Text("Excluir"),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        typePerfuration.name,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: typePerfuration.listPeriods
                            .map((e) => Text(
                                  e.name,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
