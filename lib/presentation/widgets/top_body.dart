import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/custom_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopBody extends StatelessWidget {
 TopBody({super.key});
String? selectedType;
TextEditingController _searchKey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      height: 220,

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
              top: 64,
              bottom: 32,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "BloodConnect",
                  style: AppStyles.styleBold24.copyWith(
                    color: AppColors.background,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.background,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.background.withOpacity(0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 135,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: CustomDropdownButton(onChanged: (value)=>selectedType = value)
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    Container(
                      height: 30,
                      width: 145,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextField(
                            controller: _searchKey,
                          )
                        ),
                      ),
                    ),
                    SizedBox(width: 3),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).push(AppRouter.kDonerView,
                    
                      extra: {
                        'type':selectedType,
                        'location':_searchKey.text,
                      },),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(Icons.search, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
