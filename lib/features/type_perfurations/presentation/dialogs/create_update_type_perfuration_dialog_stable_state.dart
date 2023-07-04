import 'package:ariane_app/core/validators/form_builder_validators.dart';
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

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    namePerfurationController =
        TextEditingController(text: widget.typePerfuration?.name);
    selecteds = widget.typePerfuration?.listPeriods.toList() ?? [];

    selectedMap = {};

    for (var element in widget.state.data) {
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
    final List<PeriodEntity> listPeriods = widget.state.data;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          children: [
            Text(widget.typePerfuration == null
                ? 'Novo Tipo de Perfuração'
                : 'Atualizar Tipo de Perfuração'),
            const SizedBox(height: 6),
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
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.of(context).pop(
                    TypePerfurationEntity(
                      id: widget.typePerfuration?.id ?? '',
                      name: namePerfurationController.text,
                      listPeriods: selecteds,
                    ),
                  );
                }
              },
              child: Text(
                widget.typePerfuration == null ? 'Criar' : 'Atualizar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
