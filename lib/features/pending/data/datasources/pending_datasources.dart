import 'package:ariane_app/features/pending/domain/entities/pending_entity.dart';

abstract class PendingDataSource {
  Future<List<PendingEntity>> getPendings({
    required DateTime date,
    required PendingEntity? startAfter,
    required int ammount,
  });
}
