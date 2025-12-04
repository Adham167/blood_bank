import 'package:blood_bank/features/donor/data/donation_model.dart';
import 'package:flutter/material.dart';

class DonationTile extends StatelessWidget {
  const DonationTile({super.key, required this.donationModel});
  final DonationModel donationModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Color(0xfff4e4e4),
        child: Icon(Icons.calendar_today, color: Color(0xffb75760)),
      ),
      title: Text(
        "${donationModel.time.toLocal()}".split(' ')[0],
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            donationModel.address,
            style: TextStyle(color: Color(0xff939290)),
          ),
          Text(
            donationModel.donationType,
            style: TextStyle(color: Color(0xff939290)),
          ),
        ],
      ),
    );
  }
}
