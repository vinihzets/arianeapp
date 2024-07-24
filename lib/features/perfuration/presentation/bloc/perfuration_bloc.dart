import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/perfuration/domain/usecases/read_type_perfuration_usecase_impl.dart';
import 'package:ariane_app/features/perfuration/presentation/dialogs/show_perfuration_dialog.dart';
import 'package:flutter/material.dart';
import '../../../clients/domain/entities/client_entity.dart';
import '../../perfurations.dart';

class PerfurationStableData {
  List<PerfurationEntity> listPerfurations;
  List<PeriodEntity> listPeriods;

  PerfurationStableData(
      {required this.listPerfurations, required this.listPeriods});
}

class PerfurationsBloc extends Bloc {
  final CreatePerfurationUseCaseImpl createPerfurationUseCaseImpl;
  final ReadPerfurationsUseCaseImpl readPerfurationsUseCaseImpl;
  final DeletePerfurationUseCaseImpl deletePerfurationUseCaseImpl;
  final ReadTypesPerfurationUseCaseImpl readTypesPerfurationsUseCaseImpl;

  PerfurationsBloc(
    this.createPerfurationUseCaseImpl,
    this.readPerfurationsUseCaseImpl,
    this.deletePerfurationUseCaseImpl,
    this.readTypesPerfurationsUseCaseImpl,
  );

  @override
  mapListenEvent(BlocEvent event) {
    if (event is PerfurationEventCreatePerfuration) {
      _handleCreatePerfuration(
        event.context,
        event.client,
        event.typePerfuration,
      );
    } else if (event is PerfurationEventDeletePerfuration) {
      _handleDeletePerfuration(event.context, event.entity);
    } else if (event is PerfurationReadTypePerfuration) {
      _handleReadTypePerfuration();
    }
  }

  _handleCreatePerfuration(
    BuildContext context,
    ClientEntity client,
    TypePerfurationEntity entity,
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null) {
      return;
    }

    final result = await showCustomDialog(
      // ignore: use_build_context_synchronously
      context,
      const ShowConfirmationPerfurationDialog(),
    ) as bool?;

    if (result == null) {
      return;
    }

    final createRequest = await createPerfurationUseCaseImpl(
      CreatePerfurationParams(
        clientName: client.firstName,
        clientId: client.id,
        clientNumber: client.number,
        typePerfurationEntity: entity,
        date: date,
      ),
    );

    createRequest.fold((l) {
      showFailure(context, 'Erro ao registrar perfuração');
    }, (r) {
      navigatePop(context);
      showSuccess(context, 'Sucesso ao registrar perfuração no cliente');
    });
  }

  _handleDeletePerfuration(
      BuildContext context, PerfurationEntity entity) async {
    final request = await deletePerfurationUseCaseImpl
        .call(DeletePerfurationParams(id: entity.id));

    request.fold((left) => showFailure(context, left.message), (right) {
      dispatchState(BlocStableState());
    });
  }

  _handleReadTypePerfuration() async {
    final request = await readTypesPerfurationsUseCaseImpl(NoParams());

    request.fold((l) {}, (r) {
      dispatchState(BlocStableState(data: r));
    });
  }
}
