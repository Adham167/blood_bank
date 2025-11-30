
import 'package:flutter/material.dart';

class CustomDonorButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isFilled;

  const CustomDonorButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isFilled ? const Color(0xffc22222) : Colors.transparent,
          border: Border.all(color: const Color(0xfff0f0ee), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // بدل Expanded
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isFilled ? Colors.white : const Color(0xffa3a3a3),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isFilled ? Colors.white : const Color(0xffa3a3a3),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
