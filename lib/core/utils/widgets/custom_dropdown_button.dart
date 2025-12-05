import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;
  final String label;
  final IconData icon;

  const CustomDropdownButton({
    super.key,
    required this.onChanged,
    this.selectedValue,
    this.label = "Blood Type",
    this.icon = Icons.bloodtype_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      // ✨ نفس استايل CustomTextFormField
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[700]),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
      // ✨ Items مع أيقونات جميلة
      items: const [
        DropdownMenuItem(
          value: "A+",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("A+"),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "A-",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("A-"),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "B+",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("B+"),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "B-",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("B-"),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "O+",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("O+"),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "O-",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("O-"),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "AB+",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("AB+"),
            ],
          ),
        ),
        DropdownMenuItem(
          value: "AB-",
          child: Row(
            children: [
              Icon(Icons.water_drop, color: Colors.red, size: 20),
              SizedBox(width: 10),
              Text("AB-"),
            ],
          ),
        ),
      ],
      // ✨ Hint متناسق
      hint: Text(
        "Select blood type",
        style: TextStyle(color: Colors.grey[600]),
      ),
      // ✨ التوسيط
      isExpanded: true,
      // ✨ شكل السهم
      icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
      // ✨ التحقق من القيمة (اختياري)
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select blood type';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
