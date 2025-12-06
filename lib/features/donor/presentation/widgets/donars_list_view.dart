import 'package:blood_bank/features/auth/data/models/user.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donor_list_view_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        final currentUserId = FirebaseAuth.instance.currentUser!.uid;

        final donor = doners[index];
        final isMe = donor.uid == currentUserId;

        return DonorListViewItem(donor: donor, isMe: isMe);
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
