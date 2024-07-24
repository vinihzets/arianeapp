import 'package:ariane_app/core/validators/form_builder_validators.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CreateUpdateTypePerfurationDialog extends StatefulWidget {
  final UserEntity user;
  final TypePerfurationEntity? typePerfuration;
  final List<PeriodEntity> listPeriods;

  const CreateUpdateTypePerfurationDialog({
    required this.user,
    required this.typePerfuration,
    required this.listPeriods,
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUpdateTypePerfurationDialog> createState() =>
      _CreateUpdateTypePerfurationDialogState();
}

class _CreateUpdateTypePerfurationDialogState
    extends State<CreateUpdateTypePerfurationDialog> {
  late TextEditingController namePerfurationController;
  late List<PeriodEntity> selecteds;
  late Map<PeriodEntity, bool> selectedMap;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    namePerfurationController =
        TextEditingController(text: widget.typePerfuration?.name);
    selecteds = widget.typePerfuration?.listPeriods.toList() ?? [];

    selectedMap = {};

    for (var element in widget.listPeriods) {
      selectedMap[element] = false;
    }

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
    final List<PeriodEntity> listPeriods = widget.listPeriods;

    return AlertDialog(
        title: Text(widget.typePerfuration == null
            ? 'Novo tipo de perfuração'
            : 'Atualizar tipo de perfuração'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 220,
                    child: TextFormField(
                      validator: (v) =>
                          FormBuilderValidator.customMinLengthValidator(v),
                      controller: namePerfurationController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Column(
                    children: listPeriods
                        .map((period) => CheckboxListTile(
                              title: Text(period.name),
                              value: selectedMap[period] ?? false,
                              onChanged: (bool? selecionado) {
                                setState(() {
                                  selectedMap[period] = selecionado ?? false;

                                  if (selecionado == true) {
                                    selecteds.add(period);
                                  } else {
                                    selecteds.remove(period);
                                  }
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          Navigator.of(context).pop(
                            TypePerfurationEntity(
                              id: widget.typePerfuration?.id ?? '',
                              name: namePerfurationController.text,
                              listPeriods: selecteds,
                              userId: widget.user.id,
                            ),
                          );
                        }
                      },
                      child: Text(
                        widget.typePerfuration == null ? 'Criar' : 'Atualizar',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
