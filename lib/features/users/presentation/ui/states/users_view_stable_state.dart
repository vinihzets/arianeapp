import 'package:ariane_app/core/components/custom_dropdown_button_widget.dart';
import 'package:ariane_app/core/core.dart';
import 'package:ariane_app/core/utils/date_formatter.dart';
import 'package:ariane_app/features/users/domain/entities/user_entity.dart';
import 'package:ariane_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:ariane_app/features/users/presentation/bloc/users_event.dart';
import 'package:flutter/material.dart';

class UsersViewStableState extends StatefulWidget {
  final BlocState state;
  final UsersBloc bloc;
  const UsersViewStableState(
      {required this.state, required this.bloc, super.key});

  @override
  State<UsersViewStableState> createState() => _UsersViewStableStateState();
}

class _UsersViewStableStateState extends State<UsersViewStableState> {
  List<UserEntity> get users => widget.state.data;
  UsersBloc get bloc => widget.bloc;

  final List<DropdownMenuItem> items = const [
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
        final user = users[index];

        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(user.email),
          subtitle: Row(
            children: [
              Text(DateFormatter.ddMMyyyy(
                DateTime.fromMillisecondsSinceEpoch(
                    user.date.millisecondsSinceEpoch),
              )),
              TextButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2050));

                    if (pickedDate != null) {
                      user.date = pickedDate;
                      bloc.dispatchEvent(
                          // ignore: use_build_context_synchronously
                          UpdateUserEvent(context: context, user: user));
                    }
                  },
                  child: const Text('Alterar data'))
            ],
          ),
          trailing: CustomDropdownButtonWidget(
              value: users[index].role,
              items: items,
              onChanged: (v) {
                if (v is int) {
                  user.role = v;
                  bloc.dispatchEvent(
                      UpdateUserEvent(context: context, user: user));
                }
              }),
        );
      },
    );
  }
}
