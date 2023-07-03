import 'dart:developer';

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
      CreatePerfurationParams params) async {
    final doc = databaseService.perfurations.doc();


    await doc.set({
      'id': doc.id,
      'name': params.name,
      'type_perfuration': params.listTypePerfuration.map((e) => typePerfurationMapper.toMap(e)).toList(),
    });

    return PerfurationEntity(
        name: params.name, id: doc.id, listTypePerfuration: params.listTypePerfuration);
  }

  @override
  Future<List<PerfurationEntity>> readPerfuration() async {
    final perfurations = await databaseService.perfurations.get();

    final List<PerfurationEntity> listPerfurations = perfurations.docs
        .map(
          (e) => mapper.fromMap(e.data()),
        )
        .toList();

        inspect(listPerfurations);

    return listPerfurations;
  }

  @override
  Future deletePerfuration(DeletePerfurationParams params) async {
    return await databaseService.perfurations.doc(params.id).delete();
  }

  @override
  Future<PerfurationEntity> updatePerfuration(
      UpdatePerfurationParams params) async {
    await databaseService.perfurations.doc(params.id).update({
      'name': params.name,
    });

    return PerfurationEntity(name: params.name, id: params.id, listTypePerfuration: const []);
  }

  @override
  Future<List<TypePerfurationEntity>> readTypePerfurations() async {
    final typesPerfurations = await databaseService.typePerfurations.get();


    final listType = typesPerfurations.docs.map((e) => typePerfurationMapper.fromMap(e.data())).toList();
    inspect(listType);

    
    return listType;
  }
}
