class StringTranslator {
  static build(String value) {
    if (value ==
        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
      return 'Esse email não corresponde a nenhum usuário.';
    } else if (value ==
        '[firebase_auth/unknown] Given String is empty or null') {
      return 'Email ou senha vazio preencha todos campos.';
    } else if (value ==
        '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
      return 'Senha incorreta.';
    } else if (value ==
        '[firebase_auth/invalid-email] The email address is badly formatted.') {
      return 'Email mal formatado.';
    } else if (value ==
        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
      return 'Esse email esta registrado em outra conta, tente utilizar outro.';
    } else if (value ==
        '[firebase_auth/weak-password] Password should be at least 6 characters') {
      return 'A senha deve conter pelo menos 6 caracteres.';
    }
    return '';
  }
}
