import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';

import '../../../periods.dart';

class PeriodDataSourcesRemoteImpl implements PeriodDataSources {
  DatabaseService databaseService;
  PeriodMapper mapper;
  SessionStorage sessionStorage;

  PeriodDataSourcesRemoteImpl(
    this.databaseService,
    this.mapper,
    this.sessionStorage,
  );

  @override
  Future<PeriodEntity> createPeriod(CreatePeriodParams params) async {
    final doc = databaseService.periods.doc();

    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception('Usuário não está logado');
    }

    final entity = PeriodEntity(
      dayCounter: params.dayCounter,
      monthCounter: params.monthCounter,
      yearCounter: params.yearCounter,
      name: params.name,
      message: params.message,
      id: doc.id,
      userId: session.id,
    );

    await doc.set(mapper.toMap(entity));
    return entity;
  }

  @override
  Future<List<PeriodEntity>> readPeriod() async {
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw RemoteFailure(message: 'Nenhum usuário autenticado');
    }

    final periods = await databaseService.periods
        .where('userId', isEqualTo: session.id)
        .get();

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
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception('Usuário não está logado');
    }

    final entity = PeriodEntity(
      dayCounter: params.dayCounter,
      monthCounter: params.monthCounter,
      yearCounter: params.yearCounter,
      name: params.name,
      message: params.message,
      id: params.id,
      userId: session.id,
    );

    await databaseService.periods.doc(params.id).update(mapper.toMap(entity));

    return entity;
  }
}
