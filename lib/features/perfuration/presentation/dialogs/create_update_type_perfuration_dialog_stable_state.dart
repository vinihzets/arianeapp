import 'dart:developer';

import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../perfurations.dart';

class CreateUpdatePerfurationStableState extends StatefulWidget {
  final PerfurationEntity? perfuration;
  final BlocState state;
  const CreateUpdatePerfurationStableState({
    required this.perfuration,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUpdatePerfurationStableState> createState() =>
      _CreateUpdatePerfurationStableStateState();
}

class _CreateUpdatePerfurationStableStateState
    extends State<CreateUpdatePerfurationStableState> {
  late TextEditingController namePerfurationController;
  late List<TypePerfurationEntity> selecteds;
  late Map<TypePerfurationEntity, bool> selectedMap;

  @override
  void initState() {
    namePerfurationController = TextEditingController();
    selecteds = widget.perfuration?.listTypePerfuration ?? [];
    selectedMap = {};
    for (var element in selecteds) {
      selectedMap[element] = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    namePerfurationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<TypePerfurationEntity> listTypePerfuration = widget.state.data;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        children: [
          Text(widget.perfuration == null
              ? 'Nova Perfuração'
              : 'Atualizar Perfuração'),
          const SizedBox(height: 6),
          SizedBox(
            width: 220,
            child: TextField(
              controller: namePerfurationController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          ExpansionTile(
            title: const Text('Tipos de perfuração'),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: listTypePerfuration.length,
                itemBuilder: (context, index) {
                  final typePerfuration = listTypePerfuration[index];
                  inspect(typePerfuration);

                  return CheckboxListTile(
                    title: Text(typePerfuration.name),
                    value: selectedMap[typePerfuration] ?? false,
                    onChanged: (bool? selecionado) {
                      setState(() {
                        inspect(selecionado);
                        selectedMap[typePerfuration] = selecionado ?? false;

                        if (selecionado == true) {
                          selecteds.add(typePerfuration);
                        } else {
                          selecteds.remove(typePerfuration);
                        }
                      });
                    },
                  );
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(
                PerfurationEntity(
                  id: widget.perfuration?.id ?? '',
                  name: namePerfurationController.text,
                  listTypePerfuration: selecteds,
                ),
              );
            },
            child: Text(
              widget.perfuration == null ? 'Criar' : 'Atualizar',
            ),
          ),
        ],
      ),
    );
  }
}
