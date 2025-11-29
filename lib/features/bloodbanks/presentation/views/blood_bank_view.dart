import 'package:blood_bank/features/bloodbanks/presentation/widgets/blood_bank_list_view.dart';
import 'package:flutter/material.dart';

class BloodBankView extends StatelessWidget {
  const BloodBankView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Nearby Blood Bank ",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text("3 Blood banks Found"),
            ),
            SizedBox(height: 8),
            Expanded(
              child: BloodBankListView(),
            ),
          ],
        ),
      ),
    );
  }
}
