import 'package:flutter/material.dart';

class HudMixins {
  Future<T?> showCustomDialog<T>(BuildContext context, Widget dialog) {
    return showDialog(context: context, builder: (_) => dialog);
  }

  navigateRemoveUntil(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  navigateThenUntil(BuildContext context, String routeName, Object? args) {
    Navigator.of(context).pushNamed(routeName, arguments: args);
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

  showFailure(BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text('Falha')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 90,
                  ),
                  Text(message),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Ok'))
                  ],
                )
              ],
            ));
  }

  showSuccess(BuildContext context, String message) {
    showSnack(context, message, Colors.green);
  }
}
