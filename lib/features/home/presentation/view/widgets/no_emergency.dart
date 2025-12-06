
import 'package:flutter/material.dart';

class NoEmergency extends StatelessWidget {
  const NoEmergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.green[50],
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green[600],
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              "No Active Emergencies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "All blood needs are currently met",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green[700]),
            ),
            const SizedBox(height: 12),
            Text(
              "Thank you for being a lifesaver! 🩸",
              style: TextStyle(
                color: Colors.green[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}