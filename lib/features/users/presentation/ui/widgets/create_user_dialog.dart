import 'package:ariane_app/core/utils/date_formatter.dart';
import 'package:ariane_app/core/validators/form_builder_validators.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({super.key});

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  dynamic date;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo Usuário'),
      content: Form(
        key: key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030));
                      if (pickedDate != null) {
                        date = DateFormatter.ddMMyyyy(pickedDate);
                      }

                      setState(() {});
                    },
                    child: const Text(
                      'Escolher data',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 4,
                ),
                date != null ? Text(date) : const SizedBox.shrink()
              ],
            ),
            const SizedBox(
              height: 11,
            ),
            TextFormField(
              validator: (v) => FormBuilderValidator.emailValidator(v),
              controller: emailController,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'E-mail',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.4, color: Colors.grey)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.5)),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            TextFormField(
              controller: passwordController,
              validator: (v) => FormBuilderValidator.passwordValidator(v),
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Senha',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.4, color: Colors.grey)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 0.2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.5)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (date == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Selecione uma data para prosseguir')));
                    return;
                  }

                  if (key.currentState?.validate() ?? false) {
                    key.currentState!.save();

                    Navigator.of(context).pop(UserEntity(
                        email: emailController.text,
                        role: 1,
                        password: passwordController.text));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'Criar',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )
      ],
    );
  }
}
