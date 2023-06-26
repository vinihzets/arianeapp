import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../type_perfurations.dart';

class TypePerfurationEvent extends BlocEvent {}

class TypePerfurationEventCreateTypePerfuration implements TypePerfurationEvent {
  BuildContext context;

  TypePerfurationEventCreateTypePerfuration(
    this.context,
  );
}

class TypePerfurationEventReadTypePerfuration implements TypePerfurationEvent {}

class TypePerfurationEventDeleteTypePerfuration implements TypePerfurationEvent {
  BuildContext context;
  TypePerfurationEntity entity;

  TypePerfurationEventDeleteTypePerfuration(this.context, this.entity);
}

class TypePerfurationEventUpdateTypePerfuration implements TypePerfurationEvent {
  BuildContext context;
  TypePerfurationEntity entity;

  TypePerfurationEventUpdateTypePerfuration(this.context, this.entity);
}
