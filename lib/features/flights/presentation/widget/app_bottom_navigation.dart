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
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentIndex == 0 ? AppColor.skyBlue : Colors.transparent,
              shape: BoxShape.circle,
              border: currentIndex == 0
                  ? Border.all(color: Colors.white, width: 1)
                  : null,
            ),
            child: Image.asset(
              'assets/images/nav_home.png',
              height: 30,
              color: Colors.white,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentIndex == 1 ? AppColor.skyBlue : Colors.transparent,
              shape: BoxShape.circle,
              border: currentIndex == 1
                  ? Border.all(color: Colors.white, width: 1)
                  : null,
            ),
            child: Image.asset(
              'assets/images/nav_ticket.png',
              height: 30,
              color: Colors.white,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: currentIndex == 2 ? AppColor.skyBlue : Colors.transparent,
              shape: BoxShape.circle,
              border: currentIndex == 2
                  ? Border.all(color: Colors.white, width: 1)
                  : null,
            ),
            child: Image.asset(
              'assets/images/nav_profile.png',
              height: 30,
              color: Colors.white,
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
