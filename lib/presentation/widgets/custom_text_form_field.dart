import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.isEmailField = false,
    this.onChanged,
    this.iconButton,
  });

  final String label;
  final Icon icon;
  final IconButton? iconButton;
  final bool? obscureText;
  final bool? isEmailField;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (isEmailField!) {
          if (!isValidEmail(value!)) {
            return 'Email is Invalid ';
          }
        } else if (value!.isEmpty) {
          return 'This Field is required';
        }
        return null;
      },
      onChanged: onChanged,
      obscureText: obscureText!,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon.icon, color: Colors.grey[700]),
        suffixIcon: iconButton,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffD32F2F), width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffD32F2F), width: 2),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
  }
}
