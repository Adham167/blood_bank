import 'package:blood_bank/features/bloodbanks/data/models/blood_bank_model.dart';
import 'package:blood_bank/features/bloodbanks/presentation/widgets/blood_bank_item.dart';
import 'package:flutter/material.dart';

class BloodBankListView extends StatelessWidget {
  const BloodBankListView({super.key, required this.bloodBanks});
  final List<BloodBankModel> bloodBanks;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: bloodBanks.length,
      itemBuilder: (context, index) => BloodBankItem(bloodBankModel: bloodBanks[index],),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}
