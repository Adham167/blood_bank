import 'package:blood_bank/core/app/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({super.key});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedType;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "All blood Type",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
        contentPadding: EdgeInsets.all(8),
      ),
      value: selectedType,
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
      onChanged: (String? value) {
        selectedType = value;
      },
    );
  }
}