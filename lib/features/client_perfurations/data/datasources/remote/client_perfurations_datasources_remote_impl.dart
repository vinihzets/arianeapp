import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/global/mappers/perfuration_mapper.dart';
import 'package:ariane_app/features/client_perfurations/data/datasources/client_perfurations_datasources.dart';
import 'package:ariane_app/features/periods/periods.dart';
import 'package:ariane_app/features/type_perfurations/data/data.dart';

class ClientPerfurationsDataSourcesRemoteImpl
    implements ClientPerfurationsDataSources {
  DatabaseService databaseService;

  ClientPerfurationsDataSourcesRemoteImpl(this.databaseService);

  @override
  Future<List<PerfurationEntity>> readClientPerfurations(
      ReadClientPerfurationsParams params) async {
    final listDocs = await databaseService.perfurations
        .where('clientId', isEqualTo: params.entity.id)
        .get();

    final clientPerfurations = listDocs.docs
        .map((e) => PerfurationMapper(TypePerfurationMapper(PeriodMapper()))
            .fromMap(e.data()))
        .toList();

    return clientPerfurations;
  }

  @override
  Future<void> deleteClientPerfuration(
      DeleteClientPerfurationParams params) async {
    await databaseService.perfurations.doc(params.id).delete();
  }
}
