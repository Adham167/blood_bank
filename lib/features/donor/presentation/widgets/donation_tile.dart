
import 'package:flutter/material.dart';

class DonationTile extends StatelessWidget {
  const DonationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Color(0xfff4e4e4),
        child: Icon(Icons.calendar_today, color: Color(0xffb75760)),
      ),
      title: Text(
        "Oct 26, 2025",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New York Blood Center",
            style: TextStyle(color: Color(0xff939290)),
          ),
          Text("Regular donation", style: TextStyle(color: Color(0xff939290))),
        ],
      ),
    );
  }
}
