import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/type_perfurations/domain/usecases/read_periods_usecase_impl.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/show_confirmation_dialog.dart';
import '../../type_perfurations.dart';
import '../dialogs/create_update_type_perfuration_dialog.dart';

class TypePerfurationStableData {
  List<TypePerfurationEntity> listPerfurations;
  List<PeriodEntity> listPeriods;

  TypePerfurationStableData(
      {required this.listPerfurations, required this.listPeriods});
}

class TypePerfurationsBloc extends Bloc {
  final CreateTypePerfurationUseCaseImpl createTypePerfurationUseCaseImpl;
  final ReadTypePerfurationsUseCaseImpl readTypePerfurationsUseCaseImpl;
  final DeleteTypePerfurationUseCaseImpl deleteTypePerfurationUseCaseImpl;
  final UpdateTypePerfurationsUseCaseImpl updateTypePerfurationsUseCaseImpl;
  final ReadPeriodsUseCaseImpl readPeriodsUseCaseImpl;

  late final List<TypePerfurationEntity> listTypePerfurations;

  TypePerfurationsBloc(
    this.createTypePerfurationUseCaseImpl,
    this.readTypePerfurationsUseCaseImpl,
    this.deleteTypePerfurationUseCaseImpl,
    this.updateTypePerfurationsUseCaseImpl,
    this.readPeriodsUseCaseImpl,
  ) {
    listTypePerfurations = [];
  }

  @override
  mapListenEvent(BlocEvent event) {
    if (event is TypePerfurationEventCreateTypePerfuration) {
      _handleCreateTypePerfuration(event.context);
    } else if (event is TypePerfurationEventReadTypePerfuration) {
      _handleReadTypePerfuration();
    } else if (event is TypePerfurationEventDeleteTypePerfuration) {
      _handleDeleteTypePerfuration(event.context, event.entity);
    } else if (event is TypePerfurationEventUpdateTypePerfuration) {
      _handleUpdateTypePerfuration(event.context, event.entity);
    } else if (event is TypePerfurationReadPeriods) {
      _handleReadPeriods();
    }
  }

  _handleCreateTypePerfuration(
    BuildContext context,
  ) async {
    final requestPeriods = await readPeriodsUseCaseImpl(NoParams());
    final periods = requestPeriods.fold((l) {
      return <PeriodEntity>[];
    }, (r) {
      return r;
    });

    // ignore: use_build_context_synchronously
    final TypePerfurationEntity? entity = await showCustomDialog(
      context,
      CreateUpdateTypePerfurationDialog(
        typePerfuration: null,
        listPeriods: periods,
      ),
    );

    if (entity == null) {
      return;
    }

    if (entity.listPeriods.isEmpty) {
      // ignore: use_build_context_synchronously
      showFailure(
          context, 'Não é possível criar um tipo de perfuração sem um periodo');
      return;
    }
    dispatchState(BlocLoadingState());

    final request = await createTypePerfurationUseCaseImpl(
        CreateTypePerfurationParams(
            name: entity.name, id: entity.id, periods: entity.listPeriods));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      listTypePerfurations.add(c);
      showSuccess(context, 'Tipo de perfuração cadastrado com sucesso');
      dispatchState(BlocStableState(data: listTypePerfurations));
    });
  }

  _handleReadTypePerfuration() async {
    dispatchState(BlocLoadingState());
    final request = await readTypePerfurationsUseCaseImpl.call(NoParams());

    request.fold((l) {
      dispatchState(BlocErrorState());
    },
        (r) => {
              if (r.isNotEmpty)
                {
                  listTypePerfurations.addAll(r),
                  dispatchState(BlocStableState(data: listTypePerfurations))
                }
              else
                {
                  dispatchState(BlocEmptyState()),
                }
            });
  }

  _handleDeleteTypePerfuration(
      BuildContext context, TypePerfurationEntity entity) async {
    final confirmation = await showCustomDialog(
        context,
        const ShowConfirmationDialog(
          message: 'Você realmente deseja apagar esse tipo de perfuração?',
        ));

    if (confirmation == null) {
      return;
    }

    final request = await deleteTypePerfurationUseCaseImpl
        .call(DeleteTypePerfurationParams(id: entity.id));

    request.fold((left) => showFailure(context, left.message), (right) {
      listTypePerfurations.remove(entity);

      if (listTypePerfurations.isNotEmpty) {
        dispatchState(BlocStableState(data: listTypePerfurations));
      } else {
        dispatchState(BlocEmptyState());
      }
    });
  }

  _handleUpdateTypePerfuration(
      BuildContext context, TypePerfurationEntity typeperf) async {
    final requestPeriods = await readPeriodsUseCaseImpl(NoParams());
    final periods = requestPeriods.fold((l) {
      return <PeriodEntity>[];
    }, (r) {
      return r;
    });

    // ignore: use_build_context_synchronously
    final TypePerfurationEntity? entity = await showCustomDialog(
      context,
      CreateUpdateTypePerfurationDialog(
        typePerfuration: typeperf,
        listPeriods: periods,
      ),
    );

    if (entity == null) {
      return;
    }

    if (entity.listPeriods.isEmpty) {
      // ignore: use_build_context_synchronously
      showFailure(context,
          'Não é possível atualizar um tipo de perfuração sem um periodo');
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await updateTypePerfurationsUseCaseImpl(
        UpdateTypePerfurationParams(
            name: entity.name, id: entity.id, listPeriods: entity.listPeriods));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      final index = listTypePerfurations.indexOf(typeperf);
      listTypePerfurations.remove(typeperf);
      listTypePerfurations.insert(index, c);
      dispatchState(BlocStableState(data: listTypePerfurations));
    });
  }

  _handleReadPeriods() async {
    final request = await readPeriodsUseCaseImpl(NoParams());

    request.fold((l) {}, (r) {
      dispatchState(BlocStableState(data: r));
    });
  }
}
