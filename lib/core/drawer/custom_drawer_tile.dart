import 'package:flutter/material.dart';

class CustomDrawerTile extends StatelessWidget {
  final String title;
  final String route;
  final Widget? trailing;
  final Widget? leading;

  const CustomDrawerTile({
    required this.title,
    required this.trailing,
    required this.leading,
    required this.route,
    super.key,
  });

  void onRoutePressed(BuildContext context) {
    if (ModalRoute.of(context)?.settings.name == route) {
      return Navigator.of(context).pop();
    }

    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: leading,
          trailing: trailing,
          title: Text(title),
          onTap: () => onRoutePressed(context),
        ),
      ],
    );
  }
}
