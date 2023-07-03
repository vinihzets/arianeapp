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

    final entity = PeriodEntity(
      dayCounter: params.dayCounter,
      monthCounter: params.monthCounter,
      yearCounter: params.yearCounter,
      name: params.name,
      message: params.message,
      id: doc.id,
    );

    await doc.set(mapper.toMap(entity));
    return entity;
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
    
      final entity = PeriodEntity(
      dayCounter: params.dayCounter,
      monthCounter: params.monthCounter,
      yearCounter: params.yearCounter,
      name: params.name,
      message: params.message,
      id: params.id,
    );
    
    await databaseService.periods.doc(params.id).update(mapper.toMap(entity));

    return entity;
  }
}
