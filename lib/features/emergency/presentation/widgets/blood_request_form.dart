import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/custom_dropdown_button.dart';
import 'package:flutter/material.dart';

class BloodRequestForm extends StatelessWidget {
   BloodRequestForm({super.key});

  String? selectedBloodType;

  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Blood Request Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Blood Type Dropdown
          const Text("Blood Type Needed *"),
          const SizedBox(height: 6),
          CustomDropdownButton(
            onChanged: (data) {
              selectedBloodType = data;
            },
          ),

          const SizedBox(height: 16),
          // Location Field
          const Text("Your Location"),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xfff0f0f0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.location_on, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(child: Text("Using default location (New York)")),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Additional Notes
          const Text("Additional Notes (Optional)"),
          const SizedBox(height: 6),
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  "Provide any additional details about your emergency...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Send Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.error_outline,
                color: AppColors.background,
              ),
              label: const Text(
                "Send Emergency Alert",
                style: AppStyles.styleBold16,
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffc22222),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
