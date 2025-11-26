import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_router.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/presentation/models/grid_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridViewBody extends StatelessWidget {
  GridViewBody({super.key});
  final List<GridModel> gridList = [
    GridModel(
      icon: Icon(Icons.person),
      name: "Doner",
      navigation: AppRouter.kDonerView,
    ),
    GridModel(
      icon: Icon(Icons.location_city),
      name: "Blood Bank",
      navigation: AppRouter.kBloodBankView,
    ),
    GridModel(
      icon: Icon(Icons.map_outlined),
      name: "Map View",
      navigation: AppRouter.kMapView,
    ),
    GridModel(
      icon: Icon(Icons.error_outline),
      name: "Emergency",
      navigation: AppRouter.kEmergencyView,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
          mainAxisSpacing: 12,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: gridList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => GoRouter.of(context).push(gridList[index].navigation),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),

              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Icon(
                        gridList[index].icon.icon,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      gridList[index].name,
                      style: AppStyles.styleSemiBold12.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
