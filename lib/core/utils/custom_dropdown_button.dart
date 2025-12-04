import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;

  const CustomDropdownButton({
    super.key,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: const [
        DropdownMenuItem(value: "A+", child: Text("A+")),
        DropdownMenuItem(value: "A-", child: Text("A-")),
        DropdownMenuItem(value: "B+", child: Text("B+")),
        DropdownMenuItem(value: "B-", child: Text("B-")),
        DropdownMenuItem(value: "O+", child: Text("O+")),
        DropdownMenuItem(value: "O-", child: Text("O-")),
        DropdownMenuItem(value: "AB+", child: Text("AB+")),
        DropdownMenuItem(value: "AB-", child: Text("AB-")),
      ],
      onChanged: onChanged,
    );
  }
}
