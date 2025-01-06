import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      showSelectedLabels: false, // No labels for selected items
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 35,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, size : 35),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_sharp, size: 35,),
          label: 'Settings',
        ),
      ],
      selectedItemColor: Color.fromRGBO(102, 154, 177, 100),
      unselectedItemColor: Colors.grey,
    );
  }
}
