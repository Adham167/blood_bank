import 'package:blood_bank/core/app/app_colors.dart';
import 'package:blood_bank/core/app/app_styles.dart';
import 'package:blood_bank/presentation/models/grid_model.dart';
import 'package:flutter/material.dart';

class GridViewBody extends StatelessWidget {
  GridViewBody({super.key});
  final List<GridModel> gridList = [
    GridModel(icon: Icon(Icons.person), name: "Doner"),
    GridModel(icon: Icon(Icons.location_city), name: "Blood Bank"),
    GridModel(icon: Icon(Icons.map_outlined), name: "Map View"),
    GridModel(icon: Icon(Icons.error_outline), name: "Emergency"),
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
          return Container(
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
                    child: Icon(gridList[index].icon.icon, color: Colors.red),
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
          );
        },
      ),
    );
  }
}
