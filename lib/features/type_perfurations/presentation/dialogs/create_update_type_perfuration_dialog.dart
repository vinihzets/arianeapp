import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/type_perfurations/presentation/bloc/type_bloc.dart';
import 'package:ariane_app/features/type_perfurations/presentation/bloc/type_event.dart';
import 'package:ariane_app/features/type_perfurations/presentation/dialogs/create_update_type_perfuration_dialog_stable_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/global/entities/type_perfuration_entity.dart';

class CreateUpdateTypePerfurationDialog extends StatefulWidget {
  final TypePerfurationEntity? typePerfuration;
  const CreateUpdateTypePerfurationDialog({
    required this.typePerfuration,
    super.key,
  });

  @override
  State<CreateUpdateTypePerfurationDialog> createState() =>
      _CreateUpdateTypePerfurationDialogState();
}

class _CreateUpdateTypePerfurationDialogState
    extends State<CreateUpdateTypePerfurationDialog> {
  late TextEditingController namePerfurationController;
  late TypePerfurationsBloc bloc;

  @override
  void initState() {
    namePerfurationController =
        TextEditingController(text: widget.typePerfuration?.name);
    bloc = GetIt.I.get();

    bloc.dispatchEvent(TypePerfurationReadPeriods());
    super.initState();
  }

  @override
  void dispose() {
    namePerfurationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: BlocScreenBuilder(
            stream: bloc.state,
            onStable: (onStable) => CreateUpdateTypePerfurationStableState(
                state: onStable, typePerfuration: widget.typePerfuration),
            onError: (onError) => const SizedBox.shrink(),
            onLoading: (onLoading) => const SizedBox.shrink(),
            onEmpty: (onEmpty) => const SizedBox.shrink()));
  }
}
