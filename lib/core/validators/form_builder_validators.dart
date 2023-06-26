class FormBuilderValidator {
  static String? customMinLengthValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else if (value.length < 5) {
      return 'O valor mínimo é de 5 caracteres.';
    }
    return null;
  }

  static String? customEmailValidator(String? value) {
    if (value != null) {
      return 'Nao e possivel criar um cliente com e-mail vazio!';
    }

    final regex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

    if (!regex.hasMatch(value!)) {
      return 'E-mail Invalido';
    }

    return null;
  }

  static String? customEqualToValidator(String? value, String comparisonValue) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else if (value != comparisonValue) {
      return 'Os valores não correspondem.';
    }
    return null;
  }
}
