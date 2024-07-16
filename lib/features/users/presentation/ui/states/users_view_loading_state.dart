import 'package:flutter/material.dart';

class UsersViewLoadingState extends StatefulWidget {
  const UsersViewLoadingState({super.key});

  @override
  State<UsersViewLoadingState> createState() => _UsersViewLoadingStateState();
}

class _UsersViewLoadingStateState extends State<UsersViewLoadingState> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
