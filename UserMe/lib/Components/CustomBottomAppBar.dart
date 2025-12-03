import '../Utils/utils.dart';
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const CustomBottomAppBar({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: UIColours.primaryColor,
      selectedLabelStyle: TextStyle(
        fontSize: UISizes.labelFontSize,
        fontWeight: FontWeight.w600,
      ),
      selectedFontSize: UISizes.btnFontSize,
      unselectedFontSize: UISizes.btnFontSize,
      unselectedLabelStyle: TextStyle(
        fontSize: UISizes.labelFontSize,
        fontWeight: FontWeight.w400,
      ),
      unselectedItemColor: UIColours.grey,
      onTap: onTap != null ? (index) => onTap!(index) : null,
      items: [
        BottomNavigationBarItem(
          icon: UIIcons.bottomappbarUser,
          label: UIStrings.appbarUsers,
        ),
        BottomNavigationBarItem(
          icon: UIIcons.settingsIcon,
          label: UIStrings.appbarSettings,
        ),
      ],
    );
  }
}
