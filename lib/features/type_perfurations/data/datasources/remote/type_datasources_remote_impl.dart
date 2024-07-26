import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/periods/data/data.dart';
import 'package:ariane_app/core/global/entities/period_entity.dart';
import '../../../type_perfurations.dart';

class TypePerfurationDataSourcesRemoteImpl
    implements TypePerfurationDataSources {
  DatabaseService databaseService;
  TypePerfurationMapper mapper;
  PeriodMapper periodMapper;
  SessionStorage sessionStorage;

  TypePerfurationDataSourcesRemoteImpl(
    this.databaseService,
    this.mapper,
    this.periodMapper,
    this.sessionStorage,
  );

  @override
  Future<TypePerfurationEntity> createTypePerfuration(
      CreateTypePerfurationParams params) async {
    final doc = databaseService.typePerfurations.doc();

    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception('Sem usuário logado');
    }

    await doc.set({
      'id': doc.id,
      'name': params.name,
      'periods': params.periods.map((e) => periodMapper.toMap(e)).toList(),
      'userId': session.id,
    });

    return TypePerfurationEntity(
      name: params.name,
      id: doc.id,
      listPeriods: params.periods,
      userId: session.id,
    );
  }

  @override
  Future<List<TypePerfurationEntity>> readTypesPerfuration() async {
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception('Sem usuário logado');
    }

    final perfurations = await databaseService.typePerfurations
        .where('userId', isEqualTo: session.id)
        .get();

    return perfurations.docs
        .map(
          (e) => mapper.fromMap(e.data()),
        )
        .toList();
  }

  @override
  Future deleteTypePerfuration(DeleteTypePerfurationParams params) async {
    return await databaseService.typePerfurations.doc(params.id).delete();
  }

  @override
  Future<TypePerfurationEntity> updateTypePerfuration(
    UpdateTypePerfurationParams params,
  ) async {
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception('Sem usuário logado');
    }

    await databaseService.typePerfurations.doc(params.id).update({
      'name': params.name,
      'periods': params.listPeriods.map((e) => periodMapper.toMap(e)).toList()
    });

    return TypePerfurationEntity(
      name: params.name,
      id: params.id,
      listPeriods: params.listPeriods,
      userId: session.id,
    );
  }

  @override
  Future<List<PeriodEntity>> readPeriods() async {
    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception('Sem usuário logado');
    }

    final periods = await databaseService.periods
        .where('userId', isEqualTo: session.id)
        .get();

    return periods.docs.map((e) => periodMapper.fromMap(e.data())).toList();
  }
}
