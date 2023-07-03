import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../perfurations.dart';

class PerfurationEvent extends BlocEvent {}

class PerfurationEventCreatePerfuration implements PerfurationEvent {
  BuildContext context;

  PerfurationEventCreatePerfuration(
    this.context,
  );
}

class PerfurationEventReadPerfuration implements PerfurationEvent {}

class PerfurationEventDeletePerfuration implements PerfurationEvent {
  BuildContext context;
  PerfurationEntity entity;

  PerfurationEventDeletePerfuration(this.context, this.entity);
}

class PerfurationEventUpdatePerfuration implements PerfurationEvent {
  BuildContext context;
  PerfurationEntity entity;

  PerfurationEventUpdatePerfuration(this.context, this.entity);
}

class PerfurationReadTypePerfuration implements PerfurationEvent {}
