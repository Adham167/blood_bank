import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/core/utils/custom_button.dart';
import 'package:blood_bank/core/utils/custom_dropdown_button.dart';
import 'package:blood_bank/core/utils/custom_text_field.dart';
import 'package:blood_bank/features/donor/presentation/manager/donor_cubit/donor_cubit.dart';
import 'package:blood_bank/features/donor/presentation/widgets/donars_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonerView extends StatefulWidget {
  final String? initialBloodType;
  final String? initialLocation;

  const DonerView({super.key, this.initialBloodType, this.initialLocation});

  @override
  State<DonerView> createState() => _DonerViewState();
}

class _DonerViewState extends State<DonerView> {
  String? selectedBloodType;
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectedBloodType = widget.initialBloodType;
    locationController.text = widget.initialLocation ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: const Color(0xfffafafa),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Search Doner",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
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

              // ← هنا استخدمنا القيمة الابتدائية
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

              // ← هنا حطينا الـ initialLocation
              CustomTextField(
                controller: locationController,
                hintText: "Enter City Name",
              ),

              const SizedBox(height: 16),

              CustomButton(
                title: "Search Donors",
                onTap: () {
                  /// هتعمل الفلترة هنا بعدين
                },
              ),

              const Divider(),

              BlocBuilder<DonorCubit, DonorState>(
                builder: (context, state) {
                  if (state is DonorFailure) {
                    return Center(child: Text(state.errMessage));
                  } else if (state is DonorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DonorSuccess) {
                    return DonarsListView(doners: state.doners);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
