import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:ariane_app/core/global/entities/type_perfuration_entity.dart';
import 'package:flutter/material.dart';
import '../../../clients/domain/entities/client_entity.dart';
import '../../perfurations.dart';

enum PerfurationMenuAction {
  delete,
  update,
}

class PerfurationViewStableState extends StatefulWidget {
  final BlocState state;
  final PerfurationsBloc bloc;
  const PerfurationViewStableState(
      {required this.state, required this.bloc, super.key});

  @override
  State<PerfurationViewStableState> createState() =>
      _PerfurationViewStableStateState();
}

class _PerfurationViewStableStateState
    extends State<PerfurationViewStableState> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TypePerfurationEntity> listTypePerfurations = widget.state.data;
    final client = ModalRoute.of(context)?.settings.arguments as ClientEntity?;

    return Column(
      children: [
        const Text('Tipos De Perfuração'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listTypePerfurations.length,
          itemBuilder: (context, index) {
            final typePerfuration = listTypePerfurations[index];

            return ListTile(
              leading: Text(typePerfuration.name),
              trailing: IconButton(
                  onPressed: client != null
                      ? () {
                          widget.bloc.dispatchEvent(
                              PerfurationEventCreatePerfuration(
                                  context, client, typePerfuration));
                        }
                      : null,
                  icon: const Icon(Icons.arrow_right)),
            );
          },
        ),
      ],
    );
  }
}
