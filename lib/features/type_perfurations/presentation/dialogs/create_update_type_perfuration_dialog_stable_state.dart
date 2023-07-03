import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../type_perfurations.dart';

class CreateUpdateTypePerfurationStableState extends StatefulWidget {
  final TypePerfurationEntity? typePerfuration;
  final BlocState state;
  const CreateUpdateTypePerfurationStableState({
    required this.typePerfuration,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUpdateTypePerfurationStableState> createState() =>
      _CreateUpdateTypePerfurationStableStateState();
}

class _CreateUpdateTypePerfurationStableStateState
    extends State<CreateUpdateTypePerfurationStableState> {
  late TextEditingController namePerfurationController;
  late List<PeriodEntity> selecteds;
  late Map<PeriodEntity, bool> selectedMap;

  @override
  void initState() {
    namePerfurationController = TextEditingController();
    selecteds = widget.typePerfuration?.listPeriods ?? [];
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
    final List<PeriodEntity> listPeriods = widget.state.data;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        children: [
          Text(widget.typePerfuration == null
              ? 'Novo Tipo de Perfuração'
              : 'Atualizar Tipo de Perfuração'),
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
            title: const Text('Periodos'),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: listPeriods.length,
                itemBuilder: (context, index) {
                  final period = listPeriods[index];

                  return CheckboxListTile(
                    title: Text(period.name),
                    value: selectedMap[period] ?? false,
                    onChanged: (bool? selecionado) {
                      setState(() {
                        inspect(selecionado);
                        selectedMap[period] = selecionado ?? false;

                        if (selecionado == true) {
                          selecteds.add(period);
                        } else {
                          selecteds.remove(period);
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
                TypePerfurationEntity(
                  id: widget.typePerfuration?.id ?? '',
                  name: namePerfurationController.text,
                  listPeriods: selecteds,
                ),
              );
            },
            child: Text(
              widget.typePerfuration == null ? 'Criar' : 'Atualizar',
            ),
          ),
        ],
      ),
    );
  }
}
