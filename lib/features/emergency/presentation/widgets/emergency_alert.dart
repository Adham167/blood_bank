import 'package:flutter/material.dart';

class EmergencyAlert extends StatelessWidget {
  const EmergencyAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffffebeb),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "Emergency Alert\nThis will notify all nearby matching donors immediately.",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
