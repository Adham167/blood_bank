
import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({
    super.key,
    required this.selectedType,
    required TextEditingController searchKey,
  }) : _searchKey = searchKey;

  final String? selectedType;
  final TextEditingController _searchKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {
          if (selectedType == null ||
              _searchKey.text.isEmpty) {
            return;
          }
    
          GoRouter.of(context).push(
            AppRouter.kDonerView,
            extra: {
              'type': selectedType,
              'location': _searchKey.text,
            },
          );
        },
        icon: Icon(
          Icons.search,
          color: AppColors.background,
          size: 20,
        ),
      ),
    );
  }
}
