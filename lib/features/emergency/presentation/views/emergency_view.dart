import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:flutter/material.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Emergency Request",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _EmergencyAlert(),
            SizedBox(height: 16),
            _BloodRequestForm(),
            SizedBox(height: 16),
            _NextSteps(),
          ],
        ),
      ),
    );
  }
}

// ----------------- Emergency Alert -----------------
class _EmergencyAlert extends StatelessWidget {
  const _EmergencyAlert();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffffebeb),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              "Emergency Alert\nThis will notify all nearby matching donors immediately.",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------- Blood Request Form -----------------
class _BloodRequestForm extends StatefulWidget {
  const _BloodRequestForm();

  @override
  State<_BloodRequestForm> createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<_BloodRequestForm> {
  String? selectedBloodType;

  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

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
          DropdownButtonFormField<String>(
            value: selectedBloodType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            items: const [
              DropdownMenuItem(value: "A+", child: Text("A+")),
              DropdownMenuItem(value: "A-", child: Text("A-")),
              DropdownMenuItem(value: "B+", child: Text("B+")),
              DropdownMenuItem(value: "B-", child: Text("B-")),
              DropdownMenuItem(value: "O+", child: Text("O+")),
              DropdownMenuItem(value: "O-", child: Text("O-")),
              DropdownMenuItem(value: "AB+", child: Text("AB+")),
              DropdownMenuItem(value: "AB-", child: Text("AB-")),
            ],
            onChanged: (value) {
              setState(() {
                selectedBloodType = value;
              });
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

// ----------------- Next Steps -----------------
class _NextSteps extends StatelessWidget {
  const _NextSteps();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.secondbackground, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "What happens next?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "• All donors with matching blood type in your area will be notified",
          ),
          SizedBox(height: 4),
          Text(
            "• Donors can contact you directly using the information provided",
          ),
          SizedBox(height: 4),
          Text("• Your request will be marked as active on the home screen"),
        ],
      ),
    );
  }
}