import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/presentation/widgets/blood_content_top_view.dart';
import 'package:blood_bank/presentation/widgets/location_text_field.dart';
import 'package:blood_bank/presentation/widgets/search_button_widget.dart';
import 'package:flutter/material.dart';

class TopBody extends StatefulWidget {
  const TopBody({super.key});

  @override
  State<TopBody> createState() => _TopBodyState();
}

class _TopBodyState extends State<TopBody> {
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
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text("Blood Type"),
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
                                    ]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text("🩸 $e"),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedType = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(child: LocationTextField(searchKey: _searchKey)),
                      SearchButtonWidget(
                        selectedType: selectedType,
                        searchKey: _searchKey,
                      ),
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
