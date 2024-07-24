import 'dart:convert';
import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:ariane_app/features/users/data/mappers/user_mapper.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorageImpl implements SessionStorage {
  UserMapper mapper;

  SessionStorageImpl({
    required this.mapper,
  });

  @override
  Future<UserEntity>? fetchSession() async {
    final instance = await SharedPreferences.getInstance();

    final session = instance.getString('session');

    if (session == null) {
      throw RemoteFailure(message: 'Nenhuma sessão existente');
    }

    final Map<String, dynamic> map = jsonDecode(session);

    return mapper.fromMap(map);
  }

  @override
  Future<void> removeSession() async {
    final instance = await SharedPreferences.getInstance();

    final removed = await instance.remove('session');

    if (removed) {
      return;
    }

    throw RemoteFailure(message: 'Falha ao remover sessão');
  }

  @override
  Future<void> setSession(Map<String, dynamic> session) async {
    final instance = await SharedPreferences.getInstance();
    await instance.clear();

    final setedSession = await instance.setString(
      'session',
      jsonEncode(session),
    );

    if (setedSession) {
      return;
    }

    throw RemoteFailure(message: 'Erro ao inicializar sessão');
  }
}
