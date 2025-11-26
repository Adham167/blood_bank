import 'package:blood_bank/presentation/views/emergency_view.dart';
import 'package:blood_bank/presentation/views/home_view.dart';
import 'package:blood_bank/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedIndex = 0;
  List<Widget> items = [HomeView(), EmergencyView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red,
        selectedFontSize: 18,
        unselectedItemColor: Colors.red,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.error_outline),
            label: "Emergency",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: IndexedStack(index: selectedIndex, children: items),
    );
  }
}
