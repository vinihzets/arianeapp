import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/periods/data/data.dart';
import 'package:ariane_app/core/global/entities/period_entity.dart';
import '../../../type_perfurations.dart';

class TypePerfurationDataSourcesRemoteImpl
    implements TypePerfurationDataSources {
  DatabaseService databaseService;
  TypePerfurationMapper mapper;
  PeriodMapper periodMapper;

  TypePerfurationDataSourcesRemoteImpl(
      this.databaseService, this.mapper, this.periodMapper);

  @override
  Future<TypePerfurationEntity> createTypePerfuration(
      CreateTypePerfurationParams params) async {
    final doc = databaseService.typePerfurations.doc();

    await doc.set({
      'id': doc.id,
      'name': params.name,
      'periods': params.periods.map((e) => periodMapper.toMap(e)).toList(),
    });

    return TypePerfurationEntity(
        name: params.name, id: doc.id, listPeriods: params.periods);
  }

  @override
  Future<List<TypePerfurationEntity>> readTypesPerfuration() async {
    final perfurations = await databaseService.typePerfurations.get();

    final List<TypePerfurationEntity> listPerfurations = perfurations.docs
        .map(
          (e) => mapper.fromMap(e.data()),
        )
        .toList();

    return listPerfurations;
  }

  @override
  Future deleteTypePerfuration(DeleteTypePerfurationParams params) async {
    return await databaseService.typePerfurations.doc(params.id).delete();
  }

  @override
  Future<TypePerfurationEntity> updateTypePerfuration(
      UpdateTypePerfurationParams params) async {
    await databaseService.typePerfurations.doc(params.id).update({
      'name': params.name,
      'periods': params.listPeriods.map((e) => periodMapper.toMap(e)).toList()
    });

    return TypePerfurationEntity(
        name: params.name, id: params.id, listPeriods: params.listPeriods);
  }

  @override
  Future<List<PeriodEntity>> readPeriods() async {
    final periods = await databaseService.periods.get();

    return periods.docs.map((e) => periodMapper.fromMap(e.data())).toList();
  }
}
