import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtonWidget extends StatelessWidget {
  final dynamic value;
  final List<DropdownMenuItem> items;
  final Function(Object? newObj) onChanged;
  final String? hint;
  final double? width;
  const CustomDropdownButtonWidget(
      {required this.value,
      this.hint,
      this.width,
      required this.items,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        buttonWidth: width,
        buttonHeight: 45,
        isExpanded: false,
        isDense: true,
        value: value,
        hint: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(hint ?? ''),
        ),
        onChanged: (newValue) => onChanged(newValue),
        items: items,
        dropdownDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        buttonDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
