import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/perfuration/perfurations.dart';
import 'package:ariane_app/features/perfuration/presentation/dialogs/create_update_type_perfuration_dialog_stable_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class CreateUpdatePerfurationDialog extends StatefulWidget {
  final PerfurationEntity? perfuration;
  const CreateUpdatePerfurationDialog({
    required this.perfuration,
    super.key,
  });

  @override
  State<CreateUpdatePerfurationDialog> createState() =>
      _CreateUpdatePerfurationDialogState();
}

class _CreateUpdatePerfurationDialogState
    extends State<CreateUpdatePerfurationDialog> {
  late TextEditingController name;
  late PerfurationsBloc bloc;

  @override
  void initState() {
    name = TextEditingController(text: widget.perfuration?.name);
    bloc = GetIt.I.get();

    bloc.dispatchEvent(PerfurationReadTypePerfuration());
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: BlocScreenBuilder(
            stream: bloc.state,
            onStable: (onStable) => CreateUpdatePerfurationStableState(
                state: onStable, perfuration: widget.perfuration),
            onError: (onError) => const SizedBox.shrink(),
            onLoading: (onLoading) => const SizedBox.shrink(),
            onEmpty: (onEmpty) => const SizedBox.shrink()));
  }
}
