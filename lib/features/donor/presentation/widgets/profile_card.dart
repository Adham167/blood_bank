import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.doner});
  final UserModel doner;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xfff4e4e4),
            radius: 60,
            child: Text(
              doner.name[0],
              style: TextStyle(
                fontSize: 40,
                color: Color(0xffb8383c),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            doner.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xffc2221f),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              doner.bloodType,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 24, color: Color(0xff908e8f)),
              SizedBox(width: 6),
              Text(
                doner.address,
                style: TextStyle(
                  color: Color(0xff908e8f),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, size: 24, color: Color(0xff908e8f)),
              SizedBox(width: 6),
              Text(
                doner.phone,
                style: TextStyle(
                  color: Color(0xff908e8f),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
