import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class TextFieldDelayed extends StatefulWidget {
  final Function(String) onChanged;
  final Function() onClear;
  final int delaySeconds;

  const TextFieldDelayed({
    required this.onChanged,
    required this.onClear,
    this.delaySeconds = 2,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldDelayed> createState() => _TextFieldDelayedState();
}

class _TextFieldDelayedState extends State<TextFieldDelayed> {
  late Timer? timer;
  late TextEditingController controller;
  bool isTextEmpty = true;

  @override
  void initState() {
    timer = null;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _onChanged(String text) {
    if (text.isEmpty) {
      setState(() {
        isTextEmpty = true;
      });
    } else {
      setState(() {
        isTextEmpty = false;
      });
    }

    if (timer == null) {
      timer = Timer(
        Duration(seconds: widget.delaySeconds),
        () => _onChanged(text),
      );
    } else {
      if (timer?.isActive ?? false) {
        timer?.cancel();
        timer = null;
        _onChanged(text);
      } else {
        widget.onChanged(text);
        timer = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: isTextEmpty
                  ? null
                  : () {
                      controller.clear();
                      widget.onClear();
                      isTextEmpty = true;
                      setState(() {});
                    },
              icon: const Icon(Icons.close)),
          hintText: 'Pesquisar',
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))),
      onChanged: _onChanged,
    );
  }
}
