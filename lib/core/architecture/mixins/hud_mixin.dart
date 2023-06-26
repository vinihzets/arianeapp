import 'package:flutter/material.dart';

class HudMixins {
  Future<T?> showCustomDialog<T>(BuildContext context, Widget dialog) {
    return showDialog(context: context, builder: (_) => dialog);
  }

  navigateRemoveUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  navigateThenUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  navigatePop(BuildContext context) {
    Navigator.pop(context);
  }

  showSnack(BuildContext context, String title, Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
      backgroundColor: color,
    ));
  }

  showFailure(BuildContext context, String message) {
    showSnack(context, message, Colors.red);
  }

  showSuccess(BuildContext context, String message) {
    showSnack(context, message, Colors.green);
  }
}
