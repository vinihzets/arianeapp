import 'package:ariane_app/core/architecture/usecase.dart';
import 'package:ariane_app/features/periods/domain/domain.dart';
import 'package:ariane_app/features/type_perfurations/type_perfurations.dart';

abstract class TypePerfurationDataSources {
  Future<TypePerfurationEntity> createTypePerfuration(
      CreateTypePerfurationParams entity);
  Future<List<TypePerfurationEntity>> readTypesPerfuration();
  Future<void> deleteTypePerfuration(DeleteTypePerfurationParams entity);
  Future<TypePerfurationEntity> updateTypePerfuration(
      UpdateTypePerfurationParams params);
  Future<List<PeriodEntity>> readPeriods();
}
