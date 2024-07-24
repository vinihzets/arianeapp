enum UserRole {
  disabled,
  normal,
  admin;
}

class UserEntity {
  final String email;
  UserRole role;
  final String id;
  final String? password;
  DateTime date;
  // role -> 0 inativo, 1 -> usuario->ativo, 2 -> administrador->ativo;

  UserEntity({
    required this.email,
    required this.role,
    required this.id,
    this.password,
    required this.date,
  });
}
