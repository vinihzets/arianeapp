import 'package:email_validator/email_validator.dart';

class FormBuilderValidator {
  static String? customMinLengthValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else if (value.length < 3) {
      return 'O valor mínimo é de 3 caracteres.';
    }
    return null;
  }

  static String? firstNameValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Por favor, insira o sobrenome.';
    }
    return null;
  }

  static emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '  Insira um endereço de email.';
    }
    if (!EmailValidator.validate(value)) {
      return '  Endereço de email inválido.';
    }

    return null;
  }

  static passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '  Insira uma senha.';
    }

    if (value.length < 5) {
      return '   Insira uma senha com pelomenos 6 caracteres';
    }

    return;
  }

  static String? lastNameValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Por favor, insira o sobrenome.';
    }
    return null;
  }

  static String? messageValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Por favor, insira a mensagem';
    }
    return null;
  }

  static String? numberValidator(String? value) {
    int maxLength = 15;

    if (value?.isEmpty ?? true) {
      return 'Por favor, insira o número de telefone.';
    } else if (value!.length < maxLength) {
      return 'Porfavor, insira um numero com 11 digitos';
    }
    return null;
  }

  static String? birthdayValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Por favor, insira a data de nascimento.';
    } else if (value!.length < 10) {
      return 'Insira data de nascimento corretamente DD/MM/AAAA';
    }
    return null;
  }
}
