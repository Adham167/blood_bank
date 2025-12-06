
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorsErrorWidget extends StatelessWidget {
  const DonorsErrorWidget({super.key, required this.errMessage});
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unable to load donors",
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    errMessage.length > 60
                        ? "${errMessage.substring(0, 60)}..."
                        : errMessage,
                    style: TextStyle(color: Colors.orange[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => context.read<DonorCubit>().getDonors(),
              icon: Icon(Icons.refresh, color: Colors.orange[700]),
            ),
          ],
        ),
      ),
    );
  }
}