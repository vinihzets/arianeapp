import 'package:ariane_app/core/core.dart';

abstract class ClientPerfurationsDataSources {
  Future<List<PerfurationEntity>> readClientPerfurations(
      ReadClientPerfurationsParams params);
  Future<void> deleteClientPerfuration(DeleteClientPerfurationParams params);
}
