import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/scheduling_message/domain/domain.dart';

abstract class SchedulingMessageDataSources {
  Future<SchedulingMessageEntity> createSchedulingMessage(
      CreateSchedulingMessageParams params);
}
