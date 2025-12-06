import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/bloodbanks/data/models/blood_bank_model.dart';
import 'package:blood_bank/features/bloodbanks/presentation/widgets/buttons_blood_bank.dart';
import 'package:flutter/material.dart';

class BloodBankItem extends StatelessWidget {
  const BloodBankItem({super.key, required this.bloodBankModel});
  final BloodBankModel bloodBankModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              bloodBankModel.name,
              maxLines: 1,
              style: AppStyles.styleBold20,
              overflow: TextOverflow.ellipsis,
            ),

            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondbackground,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    bloodBankModel.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.styleMedium14.copyWith(
                      color: AppColors.secondbackground,
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Icon(Icons.phone, color: AppColors.secondbackground, size: 18),
                const SizedBox(width: 4),
                Text(
                  bloodBankModel.phone,
                  style: AppStyles.styleMedium14.copyWith(
                    color: AppColors.secondbackground,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Icon(Icons.watch, color: AppColors.secondbackground, size: 18),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    bloodBankModel.timeLine,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.styleMedium14.copyWith(
                      color: AppColors.secondbackground,
                    ),
                  ),
                ),
              ],
            ),

            Align(alignment: Alignment.center, child: ButtonsBloodBank(bloodBankModel: bloodBankModel,)),
          ],
        ),
      ),
    );
  }
}
