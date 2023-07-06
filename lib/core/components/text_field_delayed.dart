import 'dart:async';

import 'package:flutter/material.dart';

class TextFieldDelayed extends StatefulWidget {
  final Function(String) onChanged;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final int delaySeconds;

  const TextFieldDelayed({
    required this.onChanged,
    this.controller,
    this.decoration,
    this.delaySeconds = 2,
    Key? key,
  }) : super(key: key);

  @override
  State<TextFieldDelayed> createState() => _TextFieldDelayedState();
}

class _TextFieldDelayedState extends State<TextFieldDelayed> {
  late Timer? timer;

  @override
  void initState() {
    timer = null;
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _onChanged(String text) {
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
      controller: widget.controller,
      decoration: widget.decoration,
      onChanged: _onChanged,
    );
  }
}
