import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/widgets/custom_app_bar.dart';
import 'package:blood_bank/core/utils/widgets/custom_button.dart';
import 'package:blood_bank/core/utils/widgets/custom_dropdown_button.dart';
import 'package:blood_bank/core/utils/widgets/custom_text_field.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/search_bloc_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonerView extends StatefulWidget {
  final String? initialBloodType;
  final String? initialLocation;

  const DonerView({
    super.key,
    this.initialBloodType = "O-",
    this.initialLocation = "cairo",
  });

  @override
  State<DonerView> createState() => _DonerViewState();
}

class _DonerViewState extends State<DonerView> {
  String? selectedBloodType;
  TextEditingController locationController = TextEditingController();

  final List<String> allowedBloodTypes = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.initialBloodType != null &&
        allowedBloodTypes.contains(widget.initialBloodType)) {
      selectedBloodType = widget.initialBloodType;
    } else {
      selectedBloodType = null;
    }

    locationController.text = widget.initialLocation ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: CustomAppBar(title: "Search Donor"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Blood Type",
                style: AppStyles.styleBold16.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              CustomDropdownButton(
                selectedValue: selectedBloodType,
                onChanged: (value) {
                  setState(() {
                    selectedBloodType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                "City / Location",
                style: AppStyles.styleBold16.copyWith(
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: locationController,
                hintText: "Enter City Name",
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: "Search Donors",
                onTap: () {
                  if (selectedBloodType != null &&
                      locationController.text.isNotEmpty) {
                    context.read<DonorCubit>().filterDonors(
                      bloodType: selectedBloodType!,
                      location: locationController.text.trim(),
                    );
                  }
                },
              ),
              const Divider(),
              SearchBlocBuilderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
