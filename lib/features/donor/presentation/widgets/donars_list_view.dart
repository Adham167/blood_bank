import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DonarsListView extends StatelessWidget {
  const DonarsListView({super.key, required this.doners, this.showAll = false});
  final List<UserModel> doners;
  final bool showAll;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final donor = doners[index];
        return ListTile(
          onTap: () => GoRouter.of(context).push(AppRouter.kDonorProfileView,extra: donor),
          leading: CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Text(
              donor.name[0],
              style: AppStyles.styleBold18.copyWith(color: AppColors.primary),
            ),
          ),
          title: Row(
            children: [
              Text(
                donor.name,
                style: AppStyles.styleBold16.copyWith(color: Colors.black),
              ),
              SizedBox(width: 6),
              Container(
                height: 25,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    donor.bloodType,
                    style: AppStyles.styleBold15.copyWith(
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.secondbackground,
                size: 18,
              ),
              SizedBox(width: 4),
              Text(
                donor.address,
                style: AppStyles.styleMedium13.copyWith(
                  color: AppColors.secondbackground,
                ),
              ),
            ],
          ),
          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.call)),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount:
          !showAll
              ? doners.length > 5
                  ? 5
                  : doners.length
              : doners.length,
    );
  }
}
