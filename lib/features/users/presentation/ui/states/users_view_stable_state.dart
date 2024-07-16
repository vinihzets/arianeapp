import 'dart:developer';

import 'package:ariane_app/core/core.dart';
import 'package:flutter/material.dart';

class UsersViewStableState extends StatefulWidget {
  final BlocState state;

  const UsersViewStableState({required this.state, super.key});

  @override
  State<UsersViewStableState> createState() => _UsersViewStableStateState();
}

class _UsersViewStableStateState extends State<UsersViewStableState> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
