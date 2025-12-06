import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/presentation/widgets/blood_content_top_view.dart';
import 'package:blood_bank/presentation/widgets/location_text_field.dart';
import 'package:blood_bank/presentation/widgets/search_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopBody extends StatelessWidget {
  TopBody({super.key});

  String? selectedType;
  final TextEditingController _searchKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            BloodContentTopView(),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      // Blood Type
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text(
                                  "Blood Type",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.primary,
                                ),
                                value: selectedType,
                                items:
                                    [
                                      "A+",
                                      "A-",
                                      "B+",
                                      "B-",
                                      "O+",
                                      "O-",
                                      "AB+",
                                      "AB-",
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          "🩸 $value",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  selectedType = value;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      VerticalDivider(
                        thickness: 1,
                        width: 1,
                        color: Colors.grey[300],
                      ),

                      // Location
                      Expanded(
                        child: LocationTextField(searchKey: _searchKey),
                      ),

                      // Search Button
                      SearchButtonWidget(selectedType: selectedType, searchKey: _searchKey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}