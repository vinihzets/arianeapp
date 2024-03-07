import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import '../../../perfurations.dart';

class PerfurationDataSourcesRemoteImpl implements PerfurationDataSources {
  DatabaseService databaseService;
  PerfurationMapper mapper;
  TypePerfurationMapper typePerfurationMapper;

  PerfurationDataSourcesRemoteImpl(
      this.databaseService, this.mapper, this.typePerfurationMapper);

  @override
  Future<PerfurationEntity> createPerfuration(
    CreatePerfurationParams params,
  ) async {
    final doc = databaseService.perfurations.doc();

    final entity = PerfurationEntity(
      clientName: params.clientName,
      clientId: params.clientId,
      createdAt: params.date.millisecondsSinceEpoch,
      id: doc.id,
      typePerfuration: params.typePerfurationEntity,
    );

    await doc.set(mapper.toMap(entity));

    return entity;
  }

  @override
  Future<List<PerfurationEntity>> readPerfuration() async {
    final perfurations = await databaseService.perfurations.get();

    return perfurations.docs
        .map(
          (e) => mapper.fromMap(e.data()),
        )
        .toList();
  }

  @override
  Future deletePerfuration(DeletePerfurationParams params) async {
    return await databaseService.perfurations.doc(params.id).delete();
  }

  @override
  Future<List<TypePerfurationEntity>> readTypePerfurations() async {
    final typesPerfurations = await databaseService.typePerfurations.get();

    return typesPerfurations.docs
        .map((e) => typePerfurationMapper.fromMap(e.data()))
        .toList();
  }
}
