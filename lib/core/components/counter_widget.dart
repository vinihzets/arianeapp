import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final int counter;
  final String label;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CounterWidget(
      {required this.label,
      required this.counter,
      required this.onAdd,
      required this.onRemove,
      super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        Row(
          children: [
            IconButton(
                onPressed: widget.onRemove, icon: const Icon(Icons.remove)),
            Text(
              widget.counter.toString(),
            ),
            IconButton(onPressed: widget.onAdd, icon: const Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}
