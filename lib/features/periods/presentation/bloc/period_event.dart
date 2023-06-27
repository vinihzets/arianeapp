import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../periods.dart';

class PeriodEvent extends BlocEvent {}

class PeriodEventCreatePeriod implements PeriodEvent {
  BuildContext context;

  PeriodEventCreatePeriod(this.context);
}

class PeriodEventReadPeriod implements PeriodEvent {}

class PeriodEventDeletePeriod implements PeriodEvent {
  BuildContext context;
  PeriodEntity entity;

  PeriodEventDeletePeriod(this.context, this.entity);
}

class PeriodEventUpdatePeriod implements PeriodEvent {
  BuildContext context;
  PeriodEntity entity;

  PeriodEventUpdatePeriod(this.context, this.entity);
}
