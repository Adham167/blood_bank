import 'package:blood_bank/features/donor/presentation/widgets/custom_donor_button.dart';
import 'package:flutter/material.dart';

class ContactButtons extends StatelessWidget {
  const ContactButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDonorButton(
                text: "Call",
                icon: Icons.call,
                isFilled: true,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomDonorButton(
                text: "Message",
                icon: Icons.message,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CustomDonorButton(
          text: "Get Directions",
          icon: Icons.navigation,
          onTap: () {},
          isFilled: false,
        ),
      ],
    );
  }
}
