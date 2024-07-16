class UserEntity {
  final String email;
  final int role;

  // role -> 0 inativo, 1 -> usuario->ativo, 2 -> administrador->ativo;

  UserEntity({required this.email, required this.role});
}
