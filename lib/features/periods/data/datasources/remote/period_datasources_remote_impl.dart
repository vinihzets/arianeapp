import '../../../../../core/architecture/usecase.dart';
import '../../../../../core/services/database_service.dart';
import '../../../periods.dart';

class PeriodDataSourcesRemoteImpl implements PeriodDataSources {
  DatabaseService databaseService;
  PeriodMapper mapper;

  PeriodDataSourcesRemoteImpl(this.databaseService, this.mapper);

  @override
  Future<PeriodEntity> createPeriod(CreatePeriodParams params) async {
    final doc = databaseService.periods.doc();

    await doc.set({
      'day': params.dayCounter,
      'month': params.monthCounter,
      'year': params.yearCounter,
      'id': doc.id,
      'name': params.name,
      'message': params.message,
    });

    return PeriodEntity(
      params.dayCounter,
      params.monthCounter,
      params.yearCounter,
      name: params.name,
      message: params.message,
      id: doc.id,
    );
  }

  @override
  Future<List<PeriodEntity>> readPeriod() async {
    final periods = await databaseService.periods.get();

    final List<PeriodEntity> listPeriods = periods.docs
        .map(
          (e) => mapper.fromMap(e.data()),
        )
        .toList();

    return listPeriods;
  }

  @override
  Future deletePeriod(DeletePeriodParams params) async {
    return await databaseService.periods.doc(params.id).delete();
  }

  @override
  Future<PeriodEntity> updatePeriod(UpdatePeriodParams params) async {
    await databaseService.periods.doc(params.id).update({
      'day': params.dayCounter,
      'month': params.monthCounter,
      'year': params.yearCounter,
      'name': params.name,
      'message': params.message,
    });

    return PeriodEntity(
      params.dayCounter,
      params.monthCounter,
      params.yearCounter,
      name: params.name,
      message: params.message,
      id: params.id,
    );
  }
}
