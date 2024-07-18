import 'package:ariane_app/core/components/custom_dropdown_button_widget.dart';
import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class UsersViewStableState extends StatefulWidget {
  final BlocState state;

  const UsersViewStableState({required this.state, super.key});

  @override
  State<UsersViewStableState> createState() => _UsersViewStableStateState();
}

class _UsersViewStableStateState extends State<UsersViewStableState> {
  List<UserEntity> get users => widget.state.data;

  final List<DropdownMenuItem> items = const [
    DropdownMenuItem(value: 0, child: Text('Inativo')),
    DropdownMenuItem(value: 1, child: Text('Usuário')),
    DropdownMenuItem(
      value: 2,
      child: Text('Admin'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(users[index].email),
          trailing: CustomDropdownButtonWidget(
              value: users[index].role, items: items, onChanged: (v) {}),
        );
      },
    );
  }
}
