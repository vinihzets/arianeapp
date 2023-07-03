import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/perfuration/domain/usecases/read_type_perfuration_usecase_impl.dart';
import 'package:flutter/material.dart';
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
  final UpdatePerfurationsUseCaseImpl updatePerfurationsUseCaseImpl;
  final ReadTypesPerfurationUseCaseImpl readPeriodsUseCaseImpl;

  late final List<PerfurationEntity> listPerfurations;

  PerfurationsBloc(
    this.createPerfurationUseCaseImpl,
    this.readPerfurationsUseCaseImpl,
    this.deletePerfurationUseCaseImpl,
    this.updatePerfurationsUseCaseImpl,
    this.readPeriodsUseCaseImpl,
  ) {
    listPerfurations = [];
  }

  @override
  mapListenEvent(BlocEvent event) {
    if (event is PerfurationEventCreatePerfuration) {
      _handleCreatePerfuration(event.context);
    } else if (event is PerfurationEventReadPerfuration) {
      _handleReadPerfuration();
    } else if (event is PerfurationEventDeletePerfuration) {
      _handleDeletePerfuration(event.context, event.entity);
    } else if (event is PerfurationEventUpdatePerfuration) {
      _handleUpdatePerfuration(event.context, event.entity);
    } else if (event is PerfurationReadTypePerfuration) {
      _handleReadPeriods();
    }
  }

  _handleCreatePerfuration(
    BuildContext context,
  ) async {
    final PerfurationEntity? entity = await showCustomDialog(
      context,
      const CreateUpdatePerfurationDialog(perfuration: null),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await createPerfurationUseCaseImpl(CreatePerfurationParams(
        name: entity.name, id: entity.id, listTypePerfuration: entity.listTypePerfuration));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      listPerfurations.add(c);
      showSuccess(context, 'Perfuratione cadastrado com sucesso');
      dispatchState(BlocStableState(data: listPerfurations));
    });
  }

  _handleReadPerfuration() async {
    dispatchState(BlocLoadingState());
    final request = await readPerfurationsUseCaseImpl.call(NoParams());

    request.fold((l) {
      dispatchState(BlocErrorState());
    },
        (r) => {
              if (r.isNotEmpty)
                {
                  listPerfurations.addAll(r),
                  dispatchState(BlocStableState(data: listPerfurations))
                }
              else
                {
                  dispatchState(BlocEmptyState()),
                }
            });
  }

  _handleDeletePerfuration(
      BuildContext context, PerfurationEntity entity) async {
    final request = await deletePerfurationUseCaseImpl
        .call(DeletePerfurationParams(id: entity.id));

    request.fold((left) => showFailure(context, left.message), (right) {
      listPerfurations.remove(entity);

      if (listPerfurations.isNotEmpty) {
        dispatchState(BlocStableState(data: listPerfurations));
      } else {
        dispatchState(BlocEmptyState());
      }
    });
  }

  _handleUpdatePerfuration(BuildContext context, PerfurationEntity perf) async {
    final PerfurationEntity? entity = await showCustomDialog(
      context,
      CreateUpdatePerfurationDialog(perfuration: perf),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await updatePerfurationsUseCaseImpl(
        UpdatePerfurationParams(name: entity.name, id: entity.id));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      final index = listPerfurations.indexOf(perf);
      listPerfurations.remove(perf);
      listPerfurations.insert(index, c);
      dispatchState(BlocStableState(data: listPerfurations));
    });
  }

  _handleReadPeriods() async {
    final request = await readPeriodsUseCaseImpl(NoParams());

    request.fold((l) {}, (r) {
      dispatchState(BlocStableState(data: r));
    });
  }
}
