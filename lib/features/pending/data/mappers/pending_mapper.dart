import 'package:ariane_app/core/architecture/mapper.dart';
import 'package:ariane_app/core/global/mappers/type_perfuration_mapper.dart';
import 'package:ariane_app/features/pending/domain/domain.dart';
import 'package:ariane_app/features/periods/data/data.dart';

class PendingMapper implements EntityMapper<PendingEntity> {
  final TypePerfurationMapper typePerfurationMapper;
  final PeriodMapper periodMapper;

  PendingMapper(
    this.typePerfurationMapper,
    this.periodMapper,
  );

  @override
  PendingEntity fromMap(Map<String, dynamic> map) {
    return PendingEntity(
      id: map['id'],
      clientName: map['clientName'],
      clientId: map['clientId'],
      message: map['message'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      sent: map['sent'],
      typePerfuration: typePerfurationMapper.fromMap(map['typePerfuration']),
      period: periodMapper.fromMap(map['period']),
    );
  }

  @override
  Map<String, dynamic> toMap(PendingEntity entity) {
    return {
      'id': entity.id,
      'clientName': entity.clientName,
      'clientId': entity.clientId,
      'message': entity.message,
      'date': entity.date.millisecondsSinceEpoch,
      'sent': entity.sent,
      'typePerfuration': typePerfurationMapper.toMap(entity.typePerfuration),
      'period': periodMapper.toMap(entity.period),
    };
  }
}
