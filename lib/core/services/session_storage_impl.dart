import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/services/session_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorageImpl implements SessionStorage {
  @override
  Future<List<String>>? fetchSession(String key) async {
    final instance = await SharedPreferences.getInstance();

    final session = instance.getStringList(key);

    if (session == null) {
      throw RemoteFailure(message: 'Nenhuma sessão existente');
    }

    return session;
  }

  @override
  Future<void> removeSession(String key) async {
    final instance = await SharedPreferences.getInstance();

    final removed = await instance.remove(key);

    if (removed) {
      return;
    }

    throw RemoteFailure(message: 'Falha ao remover sessão');
  }

  @override
  Future<void> setSession(String key, List<String> session) async {
    final instance = await SharedPreferences.getInstance();

    final setedSession = await instance.setStringList(key, session);

    if (setedSession) {
      return;
    }

    throw RemoteFailure(message: 'Erro ao inicializar sessão');
  }
}
