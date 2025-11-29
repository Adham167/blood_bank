
import 'package:blood_bank/features/bloodbanks/presentation/widgets/blood_bank_item.dart';
import 'package:flutter/material.dart';

class BloodBankListView extends StatelessWidget {
  const BloodBankListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      itemBuilder:
          (context, index) => BloodBankItem(),
      separatorBuilder:
          (context, index) => const SizedBox(height: 10),
    );
  }
}
