import 'dart:developer';

import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/periods/domain/entities/period_entity.dart';
import 'package:ariane_app/features/type_perfurations/domain/entities/type_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CreateUpdateTypePerfurationStableState extends StatefulWidget {
  final TypePerfurationEntity? typePerfuration;
  final BlocState state;
  const CreateUpdateTypePerfurationStableState(
      {required this.typePerfuration, required this.state, super.key});

  @override
  State<CreateUpdateTypePerfurationStableState> createState() =>
      _CreateUpdateTypePerfurationStableStateState();
}

class _CreateUpdateTypePerfurationStableStateState
    extends State<CreateUpdateTypePerfurationStableState> {
  late TextEditingController namePerfurationController;

  @override
  void initState() {
    namePerfurationController = TextEditingController();

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
                    return ListTile(
                      leading: Text(period.name),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.radio_button_unchecked)),
                    );
                  }),
            ],
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(TypePerfurationEntity(
              id: widget.typePerfuration?.id ?? '',
              namePerfuration: namePerfurationController.text,
            )),
            child: Text(
              widget.typePerfuration == null ? 'Criar' : 'Atualizar',
            ),
          )
        ],
      ),
    );
  }
}
