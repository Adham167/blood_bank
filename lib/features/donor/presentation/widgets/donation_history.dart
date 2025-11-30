
import 'package:blood_bank/features/donor/presentation/widgets/donation_tile.dart';
import 'package:flutter/material.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Donation History",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder:
                (context, index) => const Divider(
                  thickness: 2,
                  color: Color(0xfff1f1f1),
                  height: 1,
                ),
            itemBuilder: (context, index) {
              return const DonationTile();
            },
          ),
        ],
      ),
    );
  }
}
