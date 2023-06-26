import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/core/services/database_service.dart';
import '../../../type_perfurations.dart';



class TypePerfurationDataSourcesRemoteImpl implements TypePerfurationDataSources {
  DatabaseService databaseService;
  TypePerfurationMapper mapper;

  TypePerfurationDataSourcesRemoteImpl(this.databaseService, this.mapper);

  @override
  Future<TypePerfurationEntity> createTypePerfuration(CreateTypePerfurationParams params) async {
    final doc = databaseService.typePerfurations.doc();

    await doc.set({
      'id': doc.id,
      'namePerfuration': params.namePerfuration,
    });

    return TypePerfurationEntity(
      namePerfuration: params.namePerfuration,
      id: doc.id,
    );
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
  Future<TypePerfurationEntity> updateTypePerfuration(UpdateTypePerfurationParams params) async {
    await databaseService.typePerfurations.doc(params.id).update({
      'perfurationName': params.namePerfuration,
    });

    return TypePerfurationEntity(
        namePerfuration: params.namePerfuration,
        id: params.id);
  }
}
