abstract class SessionStorage {
  Future<List<String>>? fetchSession(String key);

  Future<void> removeSession(String key);

  Future<void> setSession(String key, List<String> session);
}
