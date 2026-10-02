import 'package:app_mobile/core/app_color.dart';
import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.slate,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/home.png'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/search.png'),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/profile.png'),
          label: 'Profile',
        ),
      ],
    );
  }
}
