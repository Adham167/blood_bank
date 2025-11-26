import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
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
              child: ListView.separated(
                itemCount: 3,
                itemBuilder:
                    (context, index) => Container(
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
                              "New York Blood center",
                              style: AppStyles.styleBold20,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.secondbackground,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "310 E 67th st, New York",
                                  style: AppStyles.styleMedium14.copyWith(
                                    color: AppColors.secondbackground,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.secondbackground,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "6.7km away",
                                  style: AppStyles.styleMedium14.copyWith(
                                    color: AppColors.secondbackground,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.watch,
                                  color: AppColors.secondbackground,
                                  size: 18,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "6.7km away",
                                  style: AppStyles.styleMedium14.copyWith(
                                    color: AppColors.secondbackground,
                                  ),
                                ),
                              ],
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: ButtonsBloodBank(),
                            ),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder:
                    (context, index) => const SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonsBloodBank extends StatelessWidget {
  const ButtonsBloodBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1, color: Colors.black),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.call),
                SizedBox(width: 6),
                Text(
                  "Call",
                  style: AppStyles.styleBold15.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16),
        Container(
          height: 30,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Center(
            child: Text(
              "Directions",
              style: AppStyles.styleBold15.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
