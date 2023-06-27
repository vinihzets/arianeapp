import 'dart:developer';

import 'package:ariane_app/core/core.dart';
import 'package:flutter/material.dart';
import '../../type_perfurations.dart';

class TypePerfurationsBloc extends Bloc {
  final CreateTypePerfurationUseCaseImpl createTypePerfurationUseCaseImpl;
  final ReadTypePerfurationsUseCaseImpl readTypePerfurationsUseCaseImpl;
  final DeleteTypePerfurationUseCaseImpl deleteTypePerfurationUseCaseImpl;
  final UpdateTypePerfurationsUseCaseImpl updateTypePerfurationsUseCaseImpl;

  late final List<TypePerfurationEntity> listTypePerfurations;

  TypePerfurationsBloc(
    this.createTypePerfurationUseCaseImpl,
    this.readTypePerfurationsUseCaseImpl,
    this.deleteTypePerfurationUseCaseImpl,
    this.updateTypePerfurationsUseCaseImpl,
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
    }
  }

  _handleCreateTypePerfuration(
    BuildContext context,
  ) async {
    final TypePerfurationEntity? entity = await showCustomDialog(
      context,
      const CreateUpdateTypePerfurationDialog(typePerfuration: null),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await createTypePerfurationUseCaseImpl(CreateTypePerfurationParams(namePerfuration: entity.namePerfuration, id: entity.id));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      listTypePerfurations.add(c);
      showSuccess(context, 'TypePerfuratione cadastrado com sucesso');
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
                {dispatchState(BlocEmptyState()),
                }
            });
  }

  _handleDeleteTypePerfuration(BuildContext context, TypePerfurationEntity entity) async {
    final request =
        await deleteTypePerfurationUseCaseImpl.call(DeleteTypePerfurationParams(id: entity.id));

    request.fold((left) => showFailure(context, left.message), (right) {
      listTypePerfurations.remove(entity);

      if (listTypePerfurations.isNotEmpty) {
        dispatchState(BlocStableState(data: listTypePerfurations));
      } else {
        dispatchState(BlocEmptyState());
      }
    });
  }

  _handleUpdateTypePerfuration(BuildContext context, TypePerfurationEntity typeperf) async {
    final TypePerfurationEntity? entity = await showCustomDialog(
      context,
      CreateUpdateTypePerfurationDialog(typePerfuration: typeperf),
    );

    if (entity == null) {
      return;
    }

    dispatchState(BlocLoadingState());

    final request = await updateTypePerfurationsUseCaseImpl(UpdateTypePerfurationParams(namePerfuration: entity.namePerfuration, id: entity.id));

    request.fold((f) => {showFailure(context, f.message)}, (c) {
      final index = listTypePerfurations.indexOf(typeperf);
      listTypePerfurations.remove(typeperf);
      listTypePerfurations.insert(index, c);
      dispatchState(BlocStableState(data: listTypePerfurations));
    });
  }
}