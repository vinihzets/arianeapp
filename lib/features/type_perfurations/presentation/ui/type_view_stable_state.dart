import 'package:ariane_app/core/architecture/bloc_state.dart';
import 'package:flutter/material.dart';
import '../../type_perfurations.dart';

enum TypePerfurationMenuAction {
  delete,
  update,
}

class TypePerfurationViewStableState extends StatefulWidget {
  final BlocState state;
  final TypePerfurationsBloc bloc;
  const TypePerfurationViewStableState(
      {required this.state, required this.bloc, super.key});

  @override
  State<TypePerfurationViewStableState> createState() =>
      _TypePerfurationViewStableStateState();
}

class _TypePerfurationViewStableStateState
    extends State<TypePerfurationViewStableState> {
  @override
  Widget build(BuildContext context) {
    List<TypePerfurationEntity> listTypePerfurations = widget.state.data;

    return ListView.builder(
      itemCount: listTypePerfurations.length,
      itemBuilder: (context, index) {
        final typePerfuration = listTypePerfurations[index];

        return ListTile(
            leading: Text(
              typePerfuration.name,
            ),
            trailing: PopupMenuButton<TypePerfurationMenuAction>(
              itemBuilder: (_) => [
                const PopupMenuItem<TypePerfurationMenuAction>(
                  value: TypePerfurationMenuAction.delete,
                  child: Text('Apagar'),
                ),
                const PopupMenuItem<TypePerfurationMenuAction>(
                  value: TypePerfurationMenuAction.update,
                  child: Text('Atualizar'),
                ),
              ],
              onSelected: (action) {
                switch (action) {
                  case TypePerfurationMenuAction.delete:
                    widget.bloc.dispatchEvent(
                        TypePerfurationEventDeleteTypePerfuration(
                            context, typePerfuration));
                    break;
                  case TypePerfurationMenuAction.update:
                    widget.bloc.dispatchEvent(
                        TypePerfurationEventUpdateTypePerfuration(
                            context, typePerfuration));
                    break;
                }
              },
            ));
      },
    );
  }
}
