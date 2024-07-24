import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:flutter/material.dart';
import '../../../../core/components/show_confirmation_dialog.dart';
import '../../periods.dart';

class PeriodsBloc extends Bloc {
  final CreatePeriodUseCaseImpl createPeriodUseCaseImpl;
  final ReadPeriodUseCaseImpl readPeriodUseCaseImpl;
  final DeletePeriodUseCaseImpl deletePeriodUseCaseImpl;
  final UpdatePeriodUseCaseImpl updatePeriodUseCaseImpl;
  final SessionStorage sessionStorage;

  late final List<PeriodEntity> listPeriods;

  PeriodsBloc(
    this.createPeriodUseCaseImpl,
    this.readPeriodUseCaseImpl,
    this.deletePeriodUseCaseImpl,
    this.updatePeriodUseCaseImpl,
    this.sessionStorage,
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
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      return;
    }

    final PeriodEntity? entity = await showCustomDialog(
      // ignore: use_build_context_synchronously
      context,
      CreateUpdatePeriodDialog(
        user: session,
        period: null,
      ),
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
      showSuccess(context, 'Periodo cadastrado com sucesso');
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
    final confirmation = await showCustomDialog(
        context,
        const ShowConfirmationDialog(
          message: 'Você realmente deseja apagar esse periodo?',
        ));

    if (confirmation == null) {
      return;
    }

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
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      return;
    }

    final PeriodEntity? entity = await showCustomDialog(
      // ignore: use_build_context_synchronously
      context,
      CreateUpdatePeriodDialog(
        user: session,
        period: period,
      ),
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
