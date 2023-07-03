import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/features/periods/domain/domain.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';
import '../../domain/entities/perfuration_entity.dart';

abstract class PerfurationDataSources {
  Future<PerfurationEntity> createPerfuration(CreatePerfurationParams entity);
  Future<List<PerfurationEntity>> readPerfuration();
  Future<void> deletePerfuration(DeletePerfurationParams entity);
  Future<PerfurationEntity> updatePerfuration(UpdatePerfurationParams params);
  Future<List<TypePerfurationEntity>> readTypePerfurations();
}
