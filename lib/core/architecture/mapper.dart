abstract class EntityMapper<T> {
  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T entity);
}
