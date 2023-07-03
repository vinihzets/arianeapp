



import 'package:ariane_app/core/core.dart';
abstract class PeriodDataSources{

    Future<PeriodEntity> createPeriod(CreatePeriodParams entity);
  Future<List<PeriodEntity>> readPeriod();
  Future<void> deletePeriod(DeletePeriodParams entity);
  Future<PeriodEntity> updatePeriod(UpdatePeriodParams params);
}
