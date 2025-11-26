import 'package:flutter/material.dart';

class DonorProfileView extends StatelessWidget {
  const DonorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Donor Profile",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: const SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          children:  [
            ProfileCard(),
            SizedBox(height: 20),
            ContactButtons(),
            SizedBox(height: 20),
            DonationHistory(),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:24),
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor:  Color(0xfff4e4e4),
            radius: 60,
            child: Text(
              "SJ",
              style: TextStyle(fontSize: 40, color: Color(0xffb8383c), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Sarah Johnson",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xffc2221f),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              "A+",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
            ),
          ),
          const SizedBox(height: 8),
         const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Icon(Icons.location_on, size: 24, color: Color(0xff908e8f)),
              SizedBox(width: 6),
              Text("0m away • New York", style: TextStyle(color: Color(0xff908e8f),fontSize: 18,fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Icon(Icons.calendar_today, size: 24, color: Color(0xff908e8f)),
              SizedBox(width: 6),
              Text("Last donation: Oct 26, 2025", style: TextStyle(color: Color(0xff908e8f),fontSize: 16,fontWeight: FontWeight.w500))
            ],
          ),
        ],
      ),
    );
  }
}

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
            itemCount:4,
            separatorBuilder: (context, index) => const Divider(
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

class DonationTile extends StatelessWidget {
  const DonationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          backgroundColor:  Color(0xfff4e4e4),
          child:  Icon(Icons.calendar_today, color: Color(0xffb75760))),
      title:  Text("Oct 26, 2025", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text("New York Blood Center",style: TextStyle(color: Color(0xff939290)),),
          Text("Regular donation", style: TextStyle(color: Color(0xff939290))),
        ],
      ),
    );
  }
}


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
          border: Border.all(
            color: const Color(0xfff0f0ee),
            width: 2,
          ),
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

