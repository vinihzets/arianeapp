import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import '../../../perfurations.dart';

class PerfurationDataSourcesRemoteImpl implements PerfurationDataSources {
  DatabaseService databaseService;
  PerfurationMapper mapper;
  TypePerfurationMapper typePerfurationMapper;
  SessionStorage sessionStorage;

  PerfurationDataSourcesRemoteImpl(
    this.databaseService,
    this.mapper,
    this.typePerfurationMapper,
    this.sessionStorage,
  );

  @override
  Future<PerfurationEntity> createPerfuration(
    CreatePerfurationParams params,
  ) async {
    final doc = databaseService.perfurations.doc();

    final localeDate = params.date.toLocal();

    final date = DateTime(
      localeDate.year,
      localeDate.month,
      localeDate.day,
      12,
      0,
    );

    final session = await sessionStorage.fetchSession();

    if (session == null) {
      throw Exception('Usuário não está logado');
    }

    final entity = PerfurationEntity(
      clientName: params.clientName,
      clientId: params.clientId,
      clientNumber: params.clientNumber,
      createdAt: date.millisecondsSinceEpoch,
      id: doc.id,
      typePerfuration: params.typePerfurationEntity,
      userId: session.id,
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
