import 'package:flutter/material.dart';

class CustomDrawerTile extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback onPressed;

  const CustomDrawerTile(
      {required this.title,
      required this.trailing,
      required this.leading,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ListTile(
            iconColor: Colors.deepPurple,
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            leading: leading,
            trailing: trailing,
            title: Text(title),
            onTap: onPressed,
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
