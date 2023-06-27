import 'dart:developer';

import 'package:ariane_app/core/core.dart';
import 'package:flutter/material.dart';
import '../../periods.dart';

class PeriodsBloc extends Bloc {
  final CreatePeriodUseCaseImpl createPeriodUseCaseImpl;
  final ReadPeriodUseCaseImpl readPeriodUseCaseImpl;
  final DeletePeriodUseCaseImpl deletePeriodUseCaseImpl;
  final UpdatePeriodUseCaseImpl updatePeriodUseCaseImpl;

  late final List<PeriodEntity> listPeriods;

  PeriodsBloc(
    this.createPeriodUseCaseImpl,
    this.readPeriodUseCaseImpl,
    this.deletePeriodUseCaseImpl,
    this.updatePeriodUseCaseImpl,
  ) {
    listPeriods = [];
  }

  @override
  mapListenEvent(BlocEvent event) {
    if (event is PeriodEventCreatePeriod) {
      _handleCreatePeriod(event.context);
    } else if (event is PeriodEventReadPeriod) {
      _handleReadPeriod();
    } else if (event is PeriodEventDeletePeriod) {
      _handleDeletePeriod(event.context, event.entity);
    } else if (event is PeriodEventUpdatePeriod) {
      _handleUpdatePeriod(event.context, event.entity);
    }
  }

  _handleCreatePeriod(
    BuildContext context,
  ) async {
    final PeriodEntity? entity = await showCustomDialog(
      context,
      const CreateUpdatePeriodDialog(period: null),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await createPeriodUseCaseImpl(CreatePeriodParams(
        name: entity.name,
        message: entity.message,
        dayCounter: entity.dayCounter,
        monthCounter: entity.monthCounter,
        yearCounter: entity.yearCounter));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      listPeriods.add(c);
      showSuccess(context, 'Periode cadastrado com sucesso');
      dispatchState(BlocStableState(data: listPeriods));
    });
  }

  _handleReadPeriod() async {
    dispatchState(BlocLoadingState());
    final request = await readPeriodUseCaseImpl.call(NoParams());

    request.fold((l) {
      dispatchState(BlocErrorState());
    },
        (r) => {
              listPeriods.addAll(r),
              if (listPeriods.isNotEmpty)
                {dispatchState(BlocStableState(data: listPeriods))}
              else
                {dispatchState(BlocEmptyState())}
            });
  }

  _handleDeletePeriod(BuildContext context, PeriodEntity entity) async {
    final request =
        await deletePeriodUseCaseImpl.call(DeletePeriodParams(id: entity.id));

    request.fold((left) => showFailure(context, left.message), (right) {
      listPeriods.remove(entity);

      if (listPeriods.isNotEmpty) {
        dispatchState(BlocStableState(data: listPeriods));
      } else {
        dispatchState(BlocEmptyState());
      }
    });
  }

  _handleUpdatePeriod(BuildContext context, PeriodEntity period) async {
    final PeriodEntity? entity = await showCustomDialog(
      context,
      CreateUpdatePeriodDialog(period: period),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await updatePeriodUseCaseImpl(UpdatePeriodParams(
      entity.dayCounter,
      entity.monthCounter,
      entity.yearCounter,
      id: entity.id,
      name: entity.name,
      message: entity.message,
    ));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      final index = listPeriods.indexOf(period);
      listPeriods.remove(period);
      listPeriods.insert(index, c);
      dispatchState(BlocStableState(data: listPeriods));
    });
  }
}
